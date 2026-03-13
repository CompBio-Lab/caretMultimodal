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
