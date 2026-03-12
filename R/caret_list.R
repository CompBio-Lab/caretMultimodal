#' @title Create a `caret_list` object
#' @description Build a list of `caret::train` objects, where each model corresponds to a data set in `data_list`.
#'   The resulting list is structured for use in ensembling workflows. Users can specify the training method, control parameters,
#'   and metrics, and the function supports error handling and model trimming for efficiency.
#' @param target Target parameter vector, either numeric for regression or a factor/character for classification.
#' @param data_list A list of data sets to train models on
#' @param method The method to train the models with. Can be a custom method or one found in `caret::modelLookup()`.
#' @param identifier_column_name The name of a column that connects the rows in the dataset (ex. a participant ID).
#' If provided, this column must be present in all datasets within the `data_list` for proper matching.
#' Use this if the datasets have different numbers of rows.
#'
#' Currently, providing `identifier_column_name` disables support for custom `trControl`, because a new
#' resampling scheme must be constructed for each dataset after row matching, which may invalidate
#' user-supplied fold indices.
#' @param trControl Control for use with the `caret::train` function.
#' If `NULL`, a default control will be constructed depending on the target type.
#' @param metric Metric for use with `caret::train` function.
#' If `NULL`, a default metric will be constructed depending on the target type.
#' @param trim Logical, whether the train models be trimmed to save memory. Default is `TRUE`
#' @param do_parallel Logical, whether to parallelize model training across datasets. Default is `TRUE`
#' @param ... Any additional arguments to pass to the `caret::train` function
#' @return A `caret_list` object, which is a list of `caret::train` model corresponding to `data_list`.
#' @export
caret_list <- function(
    target,
    data_list,
    method,
    identifier_column_name = NULL,
    trControl = NULL,
    metric = NULL,
    trim = TRUE,
    do_parallel = TRUE,
    ...) {

  if (is.null(identifier_column_name)) {
    if (!(is.vector(target) || is.factor(target))) {
      stop("Target must be a vector when no identifier column name is provided.")
    }

    for (i in seq_along(data_list)) {
      if (nrow(data_list[[i]]) != length(target)) {
        stop("The number of rows of data_list[[", i, "]] does not match the length of the target vector, and no identifier column name was provided.")
      }
    }

  } else {
    for (i in seq_along(data_list)) {
      if (!(identifier_column_name %in% colnames(data_list[[i]]))) {
        stop("The identifier column '", identifier_column_name, "' is missing in data_list[[", i, "]].")
      }
    }

    if (!(identifier_column_name %in% colnames(target))) {
      stop("The identifier column '", identifier_column_name, "' is missing in the target dataframe.")
    }

    if(ncol(target) != 2) {
      stop("Target must have exactly two columns: one serving as an identifier and the other containing values for training.")
    }
  }

  .check_method(method)

  raw_target <- if (is.null(identifier_column_name)) target else .match_identifiers(target, data_list[[1]], identifier_column_name)
  trControl <- if (is.null(trControl) | !is.null(identifier_column_name)) .default_control(raw_target) else trControl
  metric <- if (is.null(metric)) .default_metric(raw_target) else metric

  train_args <- list(...)
  train_args[["trControl"]] <- trControl
  train_args[["metric"]] <- metric
  train_args[["method"]] <- method

  if (do_parallel && foreach::getDoParWorkers() > 1) {
    message(sprintf("Using parallel backend with %d workers.", foreach::getDoParWorkers()))
  }

  operator <- if (do_parallel && foreach::getDoParWorkers() > 1) foreach::`%dopar%` else foreach::`%do%`

  model_list <- operator( foreach::foreach(data = data_list, .packages = "caret"), {

      if (is.null(identifier_column_name)) {
        train_args[["y"]] <- target
        train_args[["x"]] <- data
        train_args[["trControl"]] <- if (is.null(trControl)) .default_control(target) else trControl
      } else {
        train_args[["y"]] <- .match_identifiers(target, data, identifier_column_name)
        train_args[["x"]] <- data[, setdiff(colnames(data), identifier_column_name), drop = FALSE]
        train_args[["trControl"]] <- .default_control(train_args[["y"]]) # Only allow for the default control for now
      }

      model <- do.call(caret::train, train_args)

      if(trim) {
        model <- .trim_model(model)
      }

      # Need to add this as metadata to align the out-of-fold predictions later
      # Access with attr(obj, "identifier_column")
      if(!is.null(identifier_column_name)) {
        attr(model, "identifier_column") <- data[[identifier_column_name]]
      }

      model
  })

  if (is.null(names(data_list))) {
    names(model_list) <- paste0("data_list[[", seq_along(data_list), "]]")
  } else {
    names(model_list) <- names(data_list)
  }

  class(model_list) <- c("caret_list", "list")

  # Add on the target and identifier column for easy access later
  if (!is.null(identifier_column_name)) {
    attr(model_list, "target") <- target[[setdiff(colnames(target), identifier_column_name)]]
    attr(model_list, "identifier_column") <- target[[identifier_column_name]]
  } else {
    attr(model_list, "target") <- target
  }

  model_list
}


# Methods ------------------------------------------------------------------------------------------

#' @title Create a matrix of predictions for each model in a caret_list
#' @description This always return probabilities for classification models, with the option to drop one predicted class.
#' @param object A `caret_list` object
#' @param data_list A list of datasets to predict on, with each dataset matching the corresponding model in `caret_list`.
#' @param drop_redundant_class A boolean controlling whether to exclude the first class level from prediction output. Default is `TRUE`.
#' @param ... Additional arguments to pass to `caret::predict`
#' @return A `data.table::data.table` of predictions
#' @export
predict.caret_list <- function(
    object,
    data_list,
    drop_redundant_class = TRUE,
    ...) {

  caret_list <- object

  if (length(data_list) != length(caret_list)) {
    stop("The length of data_list must be the same length as caret_list", .call = FALSE)
  }

  row_counts <- vapply(data_list, nrow, integer(1L))
  if (!all(row_counts == row_counts[1])) {
    stop("All matrices in data_list must have the same number of rows", call. = FALSE)
  }

  data_list <- lapply(data_list, data.table::as.data.table)

  is_classifier <- caret_list[[1]]$modelType == "Classification"

  prediction_list <- lapply(seq_along(caret_list), function(i) {
    model <- caret_list[[i]]

    if (is_classifier && !is.function(model$modelInfo$prob)) {
      stop("No probability function found. Re-fit with a method that supports prob.", call. = FALSE)
    }

    pred <- caret::predict.train(
      model,
      type = if (is_classifier) "prob" else "raw",
      newdata = data_list[[i]],
      ...
    )

    pred
  })

  names(prediction_list) <- names(caret_list)

  full_matrix <- data.table::as.data.table(prediction_list)


  # Adding the full matrix as an attribute is the easiest way I could think of to
  # access it later on in caret_stack methods
  if (is_classifier && drop_redundant_class) {
    class_drop_list <- lapply(prediction_list, function(pred) pred[ ,-1])
    class_drop_matrix <- data.table::as.data.table(class_drop_list)
    attr(class_drop_matrix, "full_pred_matrix") <- full_matrix
    return(class_drop_matrix)
  }

  full_matrix
}

#' @title Out-of-fold predictions from a caret_list
#' @description Retrieve the out-of-fold predictions corresponding to the best
#'   hyperparameter setting of a trained caret model. These predictions come from
#'   the resampling process (not the final refit) and can optionally be aggregated
#'   across resamples to produce a single prediction per training instance.
#'   TODO touch up description
#' @param object A `caret_list` object
#' @param drop_redundant_class A boolean controlling whether to exclude the first class level from prediction output. Default is `TRUE`.
#' @param aggregate_resamples Logical, whether to aggregate resamples across folds.
#' @param intersection_only Logical, whether to trim down the out of fold predictions to only the intersection of
#' samples that have data in all datasets.
#' @param ... Additional arguments
#' @return A `data.table::data.table` of OOF predictions
#' @export
oof_predictions.caret_list <- function(
    object,
    drop_redundant_class = TRUE,
    aggregate_resamples = TRUE,
    intersection_only = TRUE,
    ...) {

  caret_list <- object

  is_classifier <- caret_list[[1]]$modelType == "Classification"

  prediction_list <- lapply(seq_along(caret_list), function(i) {

    model <- caret_list[[i]]

    if (is.null(model$control$savePredictions) | !model$control$savePredictions %in% c("all", "final", TRUE)) {
      stop("Must have savePredictions = 'all', 'final', or TRUE in trainControl.", call. = FALSE)
    }

    if (is_classifier && !model$control$classProbs) {
      stop("classProbs = FALSE. Re-fit with classProbs = TRUE in trainControl.", call. = FALSE)
    }

    if (is.null(model$pred) || nrow(model$pred) == 0) {
      stop("No out-of-fold predictions were generated. Check resampling setup.", call. = FALSE)
    }

    pred <- .get_oof_preds(model, aggregate_resamples)

    pred
  })


  ids_list <- lapply(caret_list, function(model) attr(model, "identifier_column"))

  if (!is.null(ids_list[[1]])) {

      keep_ids <- if (intersection_only) Reduce(intersect, ids_list) else Reduce(union, ids_list)

      prediction_list <- lapply(seq_along(prediction_list), function(i) {
        pred <- prediction_list[[i]]
        model_ids <- ids_list[[i]]
        pred[match(keep_ids, model_ids), , drop = FALSE]
      })
  }

  names(prediction_list) <- names(caret_list)

  full_matrix <- data.table::as.data.table(prediction_list)

  # Adding the full matrix as an attribute is the easiest way I could think of to
  # access it later on in caret_stack methods
  if (is_classifier && drop_redundant_class) {
    class_drop_list <- lapply(prediction_list, function(pred) pred[ ,-1])
    class_drop_matrix <- data.table::as.data.table(class_drop_list)
    attr(class_drop_matrix, "full_pred_matrix") <- full_matrix
    return(class_drop_matrix)
  }

  full_matrix
}


#' @title Provide a summary of the best tuning parameters and resampling metrics for all the `caret_list` models.
#' @param object a `caret_list` object
#' @param ... Additional arguments
#' @return A `data.table` with tunes and metrics from each model.
#' @export
summary.caret_list <- function (object, ...) {

  caret_list <- object

  metrics <- lapply(names(caret_list), function(model_name) {
    model <- caret_list[[model_name]]
    results <- data.table::as.data.table(model$results)

    if (is.null(model$bestTune) || nrow(model$bestTune) == 0) {
      best_results <- results
    } else {
      best_tune <- as.list(model$bestTune)
      best_results <- results[best_tune, on = names(best_tune)]
    }

    best_results[, method := model$method]
    best_results[, model := model_name]


    best_results
  })

  metrics <- data.table::rbindlist(metrics, use.names = TRUE, fill = TRUE)
  metrics <- metrics[, c("model", "method", setdiff(names(metrics), c("model", "method"))), with = FALSE]
  metrics
}

# Helper functions -----------------------------------------------------------------------------------------

#' @title Matches the identifiers of a target column with the rows of a data set
#' @param target The target data table (two columns: one for the variable to train on one for identifier)
#' @param data A data set to use for model training that contains an identifier column.
#' @param identifier_column_name The name of the identifier column
#' @return A vector of target variables to train on
#' @noRd
.match_identifiers <- function(
    target,
    data,
    identifier_column_name
){
  data <- data.table::as.data.table(data)
  target <- data.table::as.data.table(target)

  target <- target[target[[identifier_column_name]] %in% data[[identifier_column_name]]]
  target <- target[match(data[[identifier_column_name]], target[[identifier_column_name]])]
  target <- target[[setdiff(colnames(target), identifier_column_name)]]
  target
}

#' @title Align target vector to dataset intersections
#' This is for use when datasets with different numbers of rows are passed into `caret_list` with an
#' identifier column. It finds the target intersection in the same way `oof_predictions` does, for use in
#' training the stacked model
#' @param caret_list A  `caret_list` object
#' @return A vector
#' @noRd
.align_target <- function(
    caret_list
) {
  ids_list <- lapply(caret_list, function(model) attr(model, "identifier_column"))

  # Align the target vector and save it as an attribute to the caret_list
  target <- attr(caret_list, "target")
  target_ids <- attr(caret_list, "identifier_column")

  keep_ids <- Reduce(intersect, ids_list) # Always want the intersection

  target[match(keep_ids, target_ids)]
}
