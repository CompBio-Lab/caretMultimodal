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

compute_metric(heart_failure_stack, metric_fun, "AUC")
#>       Model       AUC
#>      <char>     <num>
#> 1:    cells 0.7435897
#> 2:   holter 0.7641026
#> 3:     mrna 0.7829060
#> 4: proteins 0.8786325
#> 5: ensemble 0.9145299
```
