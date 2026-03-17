# Provide a summary of the best tuning parameters and resampling metrics for all the `caret_list` models.

Provide a summary of the best tuning parameters and resampling metrics
for all the `caret_list` models.

## Usage

``` r
# S3 method for class 'caret_list'
summary(object, ...)
```

## Arguments

- object:

  a `caret_list` object

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table` with tunes and metrics from each model.

## Examples

``` r
# Load pre-trained caret_list object from package data
data(regression_stack)
#> Warning: data set ‘regression_stack’ not found
models <- regression_stack$caret_list
#> Error: object 'regression_stack' not found

# Models is a caret_stack object made with 7 datasets, using a GLMNET method,
# 5-fold cross validation, tuned over a grid of alpha and lambda
summary(models)
#> Error: object 'models' not found
```
