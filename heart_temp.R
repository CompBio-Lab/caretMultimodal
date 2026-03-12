set.seed(123L)
caretMultimodal::load_heart_failure()

# Set up hyperparameter tuning

alphas <- c(0.7, 0.775, 0.850, 0.925, 1)
lambdas <- seq(0.001, 0.1, by = 0.01)
tuneGrid <- expand.grid(alpha = alphas, lambda = lambdas)

####### TEMP Identifer Column Ad Hoc testing

# n <- nrow(cells)
#
# cells$id    <- seq_len(n)
# holter$id   <- seq_len(n)
# mrna$id     <- seq_len(n)
# proteins$id <- seq_len(n)
# demo$id     <- seq_len(n)

n <- nrow(demo)

multiclass_vec <- factor(
  sample(c("class1", "class2", "class3"), size = n, replace = TRUE),
  levels = c("class1", "class2", "class3")
)

# Train the base models

heart_models <- caretMultimodal::caret_list(
  target = multiclass_vec,
  data_list = list(
    cells = cells,
    holter = holter,
    mrna = mrna,
    proteins = proteins
  ),
  method = "glmnet",
  tuneGrid = tuneGrid
)

# Train the ensemble model

heart_stack <- caretMultimodal::caret_stack(
  caret_list = heart_models,
  method = "glmnet",
  tuneGrid = tuneGrid
)
