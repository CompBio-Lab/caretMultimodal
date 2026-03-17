# Get a summary of a `caret_stack` object

Get a summary of a `caret_stack` object

## Usage

``` r
# S3 method for class 'caret_stack'
summary(object, ...)
```

## Arguments

- object:

  A `caret_stack` object

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table` of methods, tuning parameters and performance metrics for
the base and ensemble model

## Examples

``` r
# Load pre-trained example caret_stack object
data(heart_failure_stack)

summary(heart_failure_stack)
#>       model method alpha lambda       ROC      Sens       Spec      ROCSD
#>      <char> <char> <num>  <num>     <num>     <num>      <num>      <num>
#> 1:    cells glmnet 0.850  0.091 0.7740741 0.9777778 0.00000000 0.14721931
#> 2:   holter glmnet 0.850  0.081 0.7851852 1.0000000 0.16666667 0.08842471
#> 3:     mrna glmnet 0.925  0.091 0.8111111 0.9777778 0.06666667 0.16789670
#> 4: proteins glmnet 0.700  0.001 0.8962963 0.9555556 0.46666667 0.09128709
#> 5: ensemble glmnet 0.925  0.071 0.9407407 0.9555556 0.40000000 0.06728112
#>        SensSD    SpecSD
#>         <num>     <num>
#> 1: 0.04969040 0.0000000
#> 2: 0.00000000 0.2357023
#> 3: 0.04969040 0.1490712
#> 4: 0.06085806 0.4472136
#> 5: 0.09938080 0.2527625
```
