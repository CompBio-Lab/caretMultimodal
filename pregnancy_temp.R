set.seed(123L)
caretMultimodal::load_gestational_age()
InputData <- lapply(InputData, as.data.frame)

# Remove postpartum samples

postpartum_indices <- which(featureweeks < 0)
InputData <- lapply(InputData, function(x) x[-postpartum_indices, ])
featurepatients <- featurepatients[-postpartum_indices]
featureweeks <- featureweeks[-postpartum_indices]

# Set up hyperparameter tuning

alphas <- seq(0, 1, 0.1)
lambdas <- seq(0, 12, by = 0.5)
tuneGrid <- expand.grid(alpha = c(0,1), lambda = 1) # Changes for speed

# Set up trControl for leave-one-sample-out cross-validation

# loso_folds <- caret::groupKFold(featurepatients, k = length(unique(featurepatients)))

loso_folds <- lapply(unique(featurepatients), function(p) {
  which(featurepatients != p)  # indices of all samples NOT in this patient
})

trControl <- caret::trainControl(
  method = "cv",
  index = loso_folds,
  savePredictions = "final",
  summaryFunction = caret::defaultSummary
)

# Train the base models


doParallel::registerDoParallel(cores = 11)

pregnancy_models <- caretMultimodal::caret_list(
  data_list = InputData,
  target = featureweeks,
  method = "glmnet",
  tuneGrid = tuneGrid,
  trControl = trControl,
  do_parallel = TRUE
)

# Train the ensemble model

pregnancy_stack <- caretMultimodal::caret_stack(
  pregnancy_models,
  method = "glmnet",
  tuneGrid = tuneGrid,
  trControl = trControl
)


# compute_model_contributions(pregnancy_stack)
# plot_model_contributions(pregnancy_stack)

# compute_feature_contributions(pregnancy_stack)
# plot_feature_contributions(pregnancy_stack)

comparison_func <- function(x,y) {-log10(cor.test(x,y,method = "spearman")$p.value)}

# compute_ablation(pregnancy_stack, comparison_func, "-log p")
# plot_ablation(pregnancy_stack, comparison_func, "-log p")
