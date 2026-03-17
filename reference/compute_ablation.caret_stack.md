# Perform an ablation analysis for a `caret_stack`

This function performs an ablation analysis on a `caret_stack` ensemble
to evaluate each base learner's contribution to predictive performance.

Starting from the full ensemble, the procedure iteratively removes one
base learner per step. At each step:

1.  The ensemble meta-learner is retrained on the remaining base
    learners, using the same `method`, `tuneGrid`, and `trControl` as
    the original stack.

2.  Variable importance scores are extracted from the retrained
    meta-learner to estimate each remaining learner's relative
    contribution.

3.  Out-of-fold predictions are generated and scored with
    `metric_function`.

4.  The learner with the lowest importance score (or highest, if
    `reverse = TRUE`) is removed before the next iteration.

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
  (e.g., RMSE, accuracy, AUC). `predictions` are the ensemble's
  out-of-fold predicted values and `target` is the response vector.

- metric_name:

  The name of the metric. Used as a row label in the returned
  `data.frame`.

- reverse:

  Logical, controls the direction to ablate in. If `FALSE`, the lowest
  contributing model is removed at each iteration. If `TRUE`, the
  highest contributing model is removed. Default is `FALSE`.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table`

## Note

This function does not support for multiclass classifiers.

## Examples

``` r
# Load pre-trained example caret_stack object
data(heart_failure_stack)

# Since the example stack is a binary classifier,
# this metric function needs to take in predictions (floats) and
# ground truth (binary vector), and produce a single number.
metric_fun <- function(preds, target) {
  pROC::roc(response = target, predictor = preds, quiet = TRUE)$auc
}

compute_ablation(heart_failure_stack, metric_fun, "AUC")
#>         Row Ablation_1 Ablation_2 Ablation_3  Ablation_4
#>      <char>      <num>      <num>      <num>       <num>
#> 1:    cells  0.0000000         NA         NA          NA
#> 2:   holter 44.1022985 44.0964872 58.8999619 100.0000000
#> 3:     mrna 35.3940024 35.0032406 41.1000381          NA
#> 4: proteins 20.5036991 20.9002722         NA          NA
#> 5:      AUC  0.9145299  0.9316239  0.8393162   0.7641026
```
