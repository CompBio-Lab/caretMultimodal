# Plot the feature level contributions to a stacked model

Constructs a bar plot with the output of the
`compute_feature_contributions` method.

## Usage

``` r
# S3 method for class 'caret_stack'
plot_feature_contributions(object, n_features = 20, ...)
```

## Arguments

- object:

  A `caret_stack` object.

- n_features:

  The maximum number of features to include. Setting to a very large
  value will include all features. Default is 20.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `ggplot2` bar plot

## Examples

``` r
# Load pre-trained example caret_stack object
data(heart_failure_stack)

plot_feature_contributions(heart_failure_stack)
```
