# Plot the results of an ablation analysis for a caret_stack model.

Contructs a bar plot with the output of the `compute_ablation` method.

## Usage

``` r
# S3 method for class 'caret_stack'
plot_ablation(object, metric_function, metric_name, reverse = FALSE, ...)
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

plot_ablation(heart_failure_stack, metric_fun, "AUC")
#> [1] "cells"
#>         Row Ablation_1
#>      <char>      <num>
#> 1:    cells  0.0000000
#> 2:   holter 44.1022985
#> 3:     mrna 35.3940024
#> 4: proteins 20.5036991
#> 5:      AUC  0.9145299
#> [1] "proteins"
#>         Row Ablation_1 Ablation_2
#>      <char>      <num>      <num>
#> 1:    cells  0.0000000         NA
#> 2:   holter 44.1022985 44.0964872
#> 3:     mrna 35.3940024 35.0032406
#> 4: proteins 20.5036991 20.9002722
#> 5:      AUC  0.9145299  0.9316239
#> [1] "mrna"
#>         Row Ablation_1 Ablation_2 Ablation_3
#>      <char>      <num>      <num>      <num>
#> 1:    cells  0.0000000         NA         NA
#> 2:   holter 44.1022985 44.0964872 58.8999619
#> 3:     mrna 35.3940024 35.0032406 41.1000381
#> 4: proteins 20.5036991 20.9002722         NA
#> 5:      AUC  0.9145299  0.9316239  0.8393162
```
