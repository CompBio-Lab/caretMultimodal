# Out-of-fold predictions from a caret_stack

Retrieve the out-of-fold predictions corresponding to the best
hyperparameter setting of a trained ensemble model. These predictions
come from the resampling process (not the final refit) and can
optionally be aggregated across resamples to produce a single prediction
per training instance.

The base model predictions returned here are the training data for the
ensemble; depending on model setup, these may be true out-of-fold
predictions or simply fitted values. For classification models, the
predictions always exclude the first class index.

## Usage

``` r
# S3 method for class 'caret_stack'
oof_predictions(
  object,
  drop_redundant_class = TRUE,
  aggregate_resamples = TRUE,
  ...
)
```

## Arguments

- object:

  A `caret_stack` object

- drop_redundant_class:

  A boolean controlling whether to exclude the first class level from
  prediction output. Default is `TRUE`.

- aggregate_resamples:

  Logical, whether to aggregate resamples across folds. Default is
  `TRUE`.

- ...:

  Not used. Included for S3 compatibility.

## Value

A
[`data.table::data.table`](https://rdrr.io/pkg/data.table/man/data.table.html)
of OOF predictions
