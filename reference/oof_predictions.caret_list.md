# Out-of-fold predictions from a caret_list

Retrieve the out-of-fold predictions corresponding to the best
hyperparameter setting of a trained caret model. These predictions come
from the resampling process (not the final refit) and can optionally be
aggregated across resamples to produce a single prediction per training
instance. TODO touch up description

## Usage

``` r
# S3 method for class 'caret_list'
oof_predictions(
  object,
  drop_redundant_class = TRUE,
  aggregate_resamples = TRUE,
  intersection_only = TRUE,
  ...
)
```

## Arguments

- object:

  A `caret_list` object

- drop_redundant_class:

  A boolean controlling whether to exclude the first class level from
  prediction output. Default is `TRUE`.

- aggregate_resamples:

  Logical, whether to aggregate resamples across folds.

- intersection_only:

  Logical, whether to trim down the out of fold predictions to only the
  intersection of samples that have data in all datasets.

- ...:

  Not used. Included for S3 compatibility.

## Value

A
[`data.table::data.table`](https://rdrr.io/pkg/data.table/man/data.table.html)
of OOF predictions
