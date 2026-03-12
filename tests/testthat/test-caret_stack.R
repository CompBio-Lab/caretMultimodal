# Setup ------------------------------------------------------------------------
library(testthat)
set.seed(192L)

# Test data --------------------------------------------------------------------

numeric_vector <- runif(30)
binary_vector <- factor(sample(c("Type1", "Type2"), 30, replace = TRUE))
multiclass_vector <- factor(sample(c("Type1", "Type2", "Type3"), 30, replace = TRUE))

make_df <- function(n = 30) {
  data.table::data.table(
    Var1 = runif(n),
    Var2 = rnorm(n),
    Var3 = runif(n, 10, 50),
    Var4 = rpois(n, lambda = 5),
    Var5 = rnorm(n, mean = 100, sd = 15)
  )
}

df1 <- make_df()
df2 <- make_df()
df3 <- make_df()


# Core tests -------------------------------------------------------------------

caret_stack_generic_test <- function(target, data_list, method) {
  models <- suppressWarnings(caret_list(target = target, data_list = data_list, method = method))
  stack <- suppressWarnings(caret_stack(caret_list = models, method = method))

  test_that("caret_stack constructor", {
    expect_s3_class(stack, "caret_stack")
    expect_s3_class(stack$ensemble, "train")
  })

  test_that("predict.caret_stack", {
    preds <- predict(stack, data_list)

    expect_s3_class(preds, "data.table")
    expect_equal(ncol(preds), length(data_list) + 1)
    expect_equal(nrow(preds), nrow(data_list[[1]]))
    expect_true("ensemble" %in% names(preds))
  })

  test_that("oof_predictions.caret_stack", {
    oof_preds <- oof_predictions(stack)

    # Can't test too much else in a generic function... need to write more specific tests
    expect_s3_class(oof_preds, "data.table")
    expect_equal(nrow(oof_preds), nrow(data_list[[1]]))
  })

  test_that("summary.caret_stack", {
    summary <- summary(stack)

    expect_s3_class(summary, "data.table")
    expect_true(all(c("model", "method") %in% names(summary)))
    expect_equal(nrow(summary), length(data_list) + 1)
  })

  test_that("compute_metric.caret_stack", {
    metric_fun <- function(x, y) { x[[1]] } # Very simple

    metrics <- compute_metric(stack, metric_function = metric_fun, metric_name = "metric")

    expect_s3_class(metrics, "data.table")
    expect_equal(nrow(metrics), length(data_list) + 1)

    expect_s3_class(plot_metric(stack, metric_function = metric_fun, metric_name = "metric"), "ggplot")
  })

  test_that("compute_model_contributions.caret_stack", {
    contribs <- compute_model_contributions(stack)

    expect_s3_class(contribs, "data.table")
    expect_equal(nrow(contribs), length(data_list))

    expect_s3_class(plot_model_contributions(stack), "ggplot")
  })

  test_that("compute_ablation.caret_stack", {
    metric_fun <- function(x, y) { x[[1]] }

    ablation <- suppressWarnings(compute_ablation(stack, metric_function = metric_fun, metric_name = "metric"))

    expect_s3_class(ablation, "data.table")
    expect_equal(nrow(ablation), length(data_list) + 1)
    expect_equal(ncol(ablation), length(data_list)) # one column for model names, then n - 1 columns for ablation runs

    expect_s3_class(suppressWarnings(plot_ablation(stack, metric_function = metric_fun, metric_name = "metric", reverse = TRUE)), "ggplot")
  })

  test_that("plot_roc.caret_stack", {
    if (length(unique(target)) == 2) {
      expect_s3_class(plot_roc(stack), "ggplot")
    } else {
      expect_error(plot_roc(stack), "ROC curves are only available for binary classifiers.")
    }
  })
}


caret_stack_generic_test(
  target = numeric_vector,
  data_list = list(df1, df2, df3),
  method = "glmnet")

# caret_stack_generic_test(
#   target = binary_vector,
#   data_list = list(df1, df2, df3),
#   method = "rf")
#
# caret_stack_generic_test(
#   target = multiclass_vector,
#   data_list = list(df1, df2, df3),
#   method = "glmnet")
