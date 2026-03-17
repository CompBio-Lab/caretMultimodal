# Compute the relative contributions of each of the base models in the ensemble model

The relative contributions are calculated using the
[`caret::varImp`](https://rdrr.io/pkg/caret/man/varImp.html) function on
the ensemble model. A scaling factor is applied to make the
contributions sum to 100%.

## Usage

``` r
# S3 method for class 'caret_stack'
compute_model_contributions(object, descending = TRUE, ...)
```

## Arguments

- object:

  A `caret_stack` object

- descending:

  Whether to sort in descending order. If `FALSE`, the output is sorted
  in ascending order. Default is `TRUE`.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table`

## Examples

``` r
# Load pre-trained example caret_stack object
data(heart_failure_stack)

compute_model_contributions(heart_failure_stack)
#>       Model Relative Contribution
#>      <char>                 <num>
#> 1:   holter               44.1023
#> 2:     mrna               35.3940
#> 3: proteins               20.5037
#> 4:    cells                0.0000
```
