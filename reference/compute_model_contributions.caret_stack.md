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
