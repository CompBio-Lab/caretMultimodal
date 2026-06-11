# This provides bindings and prevents these notes on R CMD CHECK:
# no visible binding for global variable 'X'

utils::globalVariables(c(
  ".",
  ".data",
  ".outcome",
  "AUC",
  "Ablation",
  "FPR",
  "Feature",
  "Feature_id",
  "Height",
  "Metric",
  "Model",
  "Relative Contribution",
  "Row",
  "data",
  "method",
  "raw_TPR",
  "value"
))
