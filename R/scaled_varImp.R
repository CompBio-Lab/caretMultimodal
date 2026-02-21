#' @title Compute the scaled varImp of a `caret::train` object
#' @description The relative contributions are calculated using the `caret::varImp` function on the ensemble model.
#' A scaling factor is applied to make the contributions sum to 100%.
#' @param model A `caret::train` object
#' @param descending Whether to sort in descending order. If `FALSE`, the output is sorted in ascending order.
#' @param ... Additional arguments
#' @return A `data.table`
#' @noRd
scaled_varImp <- function(
    model,
    descending = TRUE,
    ...
) {

  importance_dt <- caret::varImp(model, scale = FALSE)$importance
  importance_dt <- importance_dt / sum(importance_dt) * 100
  importance_dt <- data.table::as.data.table(importance_dt, keep.rownames = "Model")
  data.table::setnames(importance_dt, "Overall", "Relative Contribution")

  if (descending) {
    data.table::setorder(importance_dt, -`Relative Contribution`)
  } else {
    data.table::setorder(importance_dt, `Relative Contribution`)
  }

  importance_dt
}
