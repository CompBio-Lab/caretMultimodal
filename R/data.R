#' Heart Failure Datasets
#'
#' A multimodal dataset from Singh et al. (2019) containing demographic, cellular,
#' electrophysiological, and molecular features for predicting cardiac-related
#' hospitalizations. Used in examples throughout the caretMultimodal package.
#'
#' @format A named list with 5 elements:
#' \describe{
#'   \item{demo}{A \code{data.frame} of demographic features}
#'   \item{cells}{A \code{data.frame} of cell count features}
#'   \item{holter}{A \code{data.frame} of Holter monitor (ECG) features}
#'   \item{mrna}{A \code{data.frame} of mRNA expression features}
#'   \item{proteins}{A \code{data.frame} of protein abundance features}
#' }
#'
#' @source Singh et al. Ensembling Electrical and Proteogenomics Biomarkers for Improved
#'   Prediction of Cardiac-Related 3-Month Hospitalizations: A Pilot Study.
#'   \emph{Can J Cardiol.} 2019 Apr. \doi{10.1016/j.cjca.2018.11.021}
"heart_failure_datasets"


#' Pre-trained `caret_stack` on Heart Failure Datasets
#'
#' A `caret_stack` object pre-trained on `heart_failure_datasets`.
#' Used in examples throughout the caretMultimodal package.
#'
#' @format A `caret_stack` object
#'
#' @seealso [`heart_failure_datasets`]
"heart_failure_stack"
