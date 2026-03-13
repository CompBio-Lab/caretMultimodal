# Compute metrics with a provided metric function

The metric_function is applied to the out-of-fold predictions for the
caret_stack.

## Usage

``` r
# S3 method for class 'caret_stack'
compute_metric(object, metric_function, metric_name, descending = TRUE, ...)
```

## Arguments

- object:

  A `caret_stack` object

- metric_function:

  A function that takes two arguments `(predictions, target)` and
  returns a single numeric value representing the metric to compute
  (e.g., RMSE, accuracy, AUC).

- metric_name:

  The name of the metric

- descending:

  Whether to sort in descending order. If `FALSE`, the output is sorted
  in ascending order. Default is `TRUE`.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table` of metrics
