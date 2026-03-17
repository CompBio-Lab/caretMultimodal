# This file is where all the S3 methods for the caretMultimodal package are registered

#' @export
oof_predictions <- function(object, ...) {
  UseMethod("oof_predictions")
}

#' @export
plot_roc <- function(object, ...) {
  UseMethod("plot_roc")
}

#' @export
compute_metric <- function(object, ...) {
  UseMethod("compute_metric")
}

#' @export
plot_metric <- function(object, ...) {
  UseMethod("plot_metric")
}

#' @export
compute_model_contributions <- function(object, ...) {
  UseMethod("compute_model_contributions")
}

#' @export
plot_model_contributions <- function(object, ...) {
  UseMethod("plot_model_contributions")
}

#' @export
compute_ablation <- function(object, ...) {
  UseMethod("compute_ablation")
}

#' @export
plot_ablation <- function(object, ...) {
  UseMethod("plot_ablation")
}

#' @export
compute_feature_contributions <- function(object, ...) {
  UseMethod("compute_feature_contributions")
}

#' @export
plot_feature_contributions <- function(object, ...) {
  UseMethod("plot_feature_contributions")
}

