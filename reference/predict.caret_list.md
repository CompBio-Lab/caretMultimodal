# Create a matrix of predictions for each model in a caret_list

This always return probabilities for classification models, with the
option to drop one predicted class.

## Usage

``` r
# S3 method for class 'caret_list'
predict(object, data_list, drop_redundant_class = TRUE, ...)
```

## Arguments

- object:

  A `caret_list` object

- data_list:

  A list of datasets to predict on, with each dataset matching the
  corresponding model in `caret_list`.

- drop_redundant_class:

  A boolean controlling whether to exclude the first class level from
  prediction output. Default is `TRUE`.

- ...:

  Additional arguments to pass to `caret::predict`

## Value

A
[`data.table::data.table`](https://rdrr.io/pkg/data.table/man/data.table.html)
of predictions
