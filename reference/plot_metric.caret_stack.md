# Plot metrics computed with a provided metric function

This function constructs a bar plot with the output of the compute
metric method. The bars are ordered by increasing value.

## Usage

``` r
# S3 method for class 'caret_stack'
plot_metric(object, metric_function, metric_name, descending = TRUE, ...)
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

A `ggplot2` bar chart
