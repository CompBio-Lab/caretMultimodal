#' @title Prepare a MultiAssayExperiment for use with caretMultimodal
#' @description Converts a MultiAssayExperiment object from the MultiAssayExperiment package to a
#' simple list of datasets to pass into `caret_list`.
#' @param mae The MultiAssayExperiment object.
#' @param transpose Whether to transpose the individual matrices. Samples must correspond to rows for caret_list.
#' Default is FALSE.
#' @param ... Not used. Included for S3 compatibility.
#' @return A named list of matrices.
#' @export
prepare_mae <- function(
    mae,
    transpose = FALSE,
    ...) {

  exp_list <- MultiAssayExperiment::experiments(mae)

  data_list <- lapply(exp_list, function(se) {
    if (transpose) t(MultiAssayExperiment::assay(se)) else MultiAssayExperiment::assay(se)
  })

  data_list
}
