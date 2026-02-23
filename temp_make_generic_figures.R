set.seed(123L)

caretMultimodal::load_heart_failure()

# Set up hyperparameter tuning

alphas <- c(0.7, 0.775, 0.850, 0.925, 1)
lambdas <- seq(0.001, 0.1, by = 0.01)
tuneGrid <- expand.grid(alpha = alphas, lambda = lambdas)

# Make names generic

data_list <- list(cells, holter, mrna, proteins)

# Generic dataset names
names(data_list) <- paste0("Dataset ", seq_along(data_list))

# Generic feature names
data_list <- lapply(data_list, function(df) {
  colnames(df) <- paste0("Feature ", seq_len(ncol(df)))
  df
})


# Train the base models

base_models <- caretMultimodal::caret_list(
  target = demo$hospitalizations,
  data_list = data_list,
  method = "glmnet",
  tuneGrid = tuneGrid
)

# Train the ensemble model

stacked_model <- caretMultimodal::caret_stack(
  caret_list = base_models,
  method = "glmnet",
  tuneGrid = tuneGrid
)

metric_func <- function(pred, targ) {
  pROC::roc(response = targ, predictor = pred, quiet = TRUE)$auc
}

plot_list <- list(
  roc                 = plot_roc(stacked_model),
  model_contrib       = plot_model_contributions(stacked_model),
  feature_contrib     = plot_feature_contributions(stacked_model),
  ablation_forward    = plot_ablation(stacked_model, metric_func, "AUROC"),
  ablation_reverse    = plot_ablation(stacked_model, metric_func, "AUROC", reverse = TRUE),
  metric              = plot_metric(stacked_model, metric_func, "AUROC")
)

# Save each figure with identical dimensions
for (nm in names(plot_list)) {
  ggsave(
    filename = paste0("plots/", nm, ".png"),
    plot = plot_list[[nm]],
    width = 180,
    height = 120,
    units = "mm",
    dpi = 300
  )
}
