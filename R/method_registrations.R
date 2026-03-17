# This file is where all the S3 methods for the caretMultimodal package are registered

#' @title Extract out-of-fold predictions from `caret_list` or `caret_stack` objects
#' @param object A `caret_list` or `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
oof_predictions <- function(object, ...) {
  UseMethod("oof_predictions")
}

#' @title Make an ROC plot for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
plot_roc <- function(object, ...) {
  UseMethod("plot_roc")
}

#' @title Compute metrics for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
compute_metric <- function(object, ...) {
  UseMethod("compute_metric")
}

#' @title Plot metrics for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
plot_metric <- function(object, ...) {
  UseMethod("plot_metric")
}

#' @title Compute base model contributions for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
compute_model_contributions <- function(object, ...) {
  UseMethod("compute_model_contributions")
}

#' @title Plot base model contributions for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
plot_model_contributions <- function(object, ...) {
  UseMethod("plot_model_contributions")
}

#' @title Conduct an ablation analysis with a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
compute_ablation <- function(object, ...) {
  UseMethod("compute_ablation")
}

#' @title Plot an ablation analysis with a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
plot_ablation <- function(object, ...) {
  UseMethod("plot_ablation")
}

#' @title Compute feature level contributions for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
compute_feature_contributions <- function(object, ...) {
  UseMethod("compute_feature_contributions")
}

#' @title Plot feature level contributions for a `caret_stack` object
#' @param object A `caret_stack` object
#' @param ... Additional arguments passed to class-specific methods
#' @export
#' @keywords internal
plot_feature_contributions <- function(object, ...) {
  UseMethod("plot_feature_contributions")
}

