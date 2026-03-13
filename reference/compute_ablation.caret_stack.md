# Perform an ablation analysis for a caret_stack model.

This function performs a systematic ablation analysis on a `caret_stack`
ensemble to evaluate each base learner's contribution to predictive
performance. The procedure begins with the full set of base model
predictions and iteratively removes one model at a time. At each
iteration, the ensemble model is retrained on the remaining learners
using the same `method`, `tuneGrid`, and `trControl` settings as the
original stack. Model importance in the ensemble is estimated, and the
learner with the lowest (or highest, if `reverse = TRUE`) relative
contribution is removed.

After each ablation step, out-of-fold predictions are generated and
evaluated using the user-supplied `metric_function`, which should accept
two arguments `(predictions, target)` and return a single numeric value
(e.g., RMSE, accuracy, AUC). The resulting performance metrics and model
contribution estimates are recorded at each stage and returned as a
`data.table`.

## Usage

``` r
# S3 method for class 'caret_stack'
compute_ablation(object, metric_function, metric_name, reverse = FALSE, ...)
```

## Arguments

- object:

  A `caret_stack` object.

- metric_function:

  A function that takes two arguments `(predictions, target)` and
  returns a single numeric value representing the metric to compute
  (e.g., RMSE, accuracy, AUC).

- metric_name:

  The name of the metric

- reverse:

  The direction to ablate in. If `FALSE`, the lowest contributing model
  is removed at each iteration. If `TRUE`, the highest contributing
  model is removed. Default is `FALSE`.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table`
