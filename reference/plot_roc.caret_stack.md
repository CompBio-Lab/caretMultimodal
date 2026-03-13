# Plot ROC curves for individual and ensemble models in a caret_stack

This function calculates ROC curves for all base models and the ensemble
model using the out-of-fold predictions from a `caret_stack` object. The
`pROC` package is used to compute the ROC curves. ROC curves can only be
constructed for binary calssifiers.

## Usage

``` r
# S3 method for class 'caret_stack'
plot_roc(object, include_auc = TRUE, ...)
```

## Arguments

- object:

  A `caret_stack` object

- include_auc:

  Whether to include AUC values in the legend. Default is `True`.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `ggplot2` object
