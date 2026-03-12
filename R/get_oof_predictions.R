
#' @title Extract the best out-of-fold predictions from a `caret::train` object
#' @description Retrieve the out-of-fold predictions corresponding to the best
#'   hyperparameter setting of a trained caret model. These predictions come from
#'   the resampling process (not the final refit) and can optionally be aggregated
#'   across resamples to produce a single prediction per training instance.
#'
#' @import data.table
#' @param model A `caret::train` object
#' @param aggregate_resamples Whether to aggregate out-of-fold predictions across multiple resamples.
#' @return A `data.table::data.table` with out-of-fold predictions
#' @noRd
.get_oof_preds <- function(model, aggregate_resamples) {

  if (is.null(model[["pred"]])) {
    stop("No predictions saved during training. Check resampling setup.", call. = FALSE)
  }

  if (!is.null(model$bestTune) && nrow(model$bestTune) > 0 && !(ncol(model$bestTune) == 1 && model$bestTune[[1]] == "none")) {
    keys <- names(model$bestTune)
    best_tune <- data.table::data.table(model$bestTune, key = keys)

    pred <- data.table::data.table(model$pred, key = keys)
    pred <- pred[best_tune, ]
  } else {
    pred <- data.table::data.table(model$pred)
  }

  keep_cols <- if (model$modelType == "Classification") levels(model) else "pred"


  data.table::setorderv(pred, "rowIndex")

  if (aggregate_resamples) {
    pred <- pred[, lapply(.SD, .aggregate_vector), by = "rowIndex"]
    pred <- pred[, keep_cols, with = FALSE]
  } else {
    pred <- pred[, c("rowIndex", "Resample", keep_cols), with = FALSE]
  }

  pred
}

#' @title Aggregate vector
#' @description Aggregate a vector depending on its type.
#' For numeric data return the mean.
#' For factor data return the mode.
#' @param x A vector to be aggregated.
#' @return The mean of numeric data or the mode of non-numeric data.
#' @noRd
.aggregate_vector <- function(x) {
  if (is.numeric(x)) {
    mean(x)
  } else {
    names(sort(table(x), decreasing = TRUE))[1L]
  }
}


