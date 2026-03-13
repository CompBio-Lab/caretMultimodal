# Ensemble the models of a `caret_list` object

Train an ensemble (stacked) model from the base learners in a
`caret_list`. The ensemble is itself a
[`caret::train`](https://rdrr.io/pkg/caret/man/train.html) model that
learns to combine the predictions of the base models. By default, the
meta-learner is trained on out-of-fold predictions from the resampling
process, ensuring that the ensemble does not overfit to in-sample
predictions. Alternatively, new datasets can be supplied via `data_list`
and `target` for transfer-learning style ensembling.

## Usage

``` r
caret_stack(
  caret_list,
  method,
  data_list = NULL,
  target = NULL,
  metric = NULL,
  trControl = NULL,
  ...
)
```

## Arguments

- caret_list:

  a `caret_list` object

- method:

  The method to train the ensemble model. Can be a custom method or one
  found in
  [`caret::modelLookup()`](https://rdrr.io/pkg/caret/man/modelLookup.html).

- data_list:

  A list of datasets to predict on, with each dataset matching the
  corresponding model in `caret_list`. If `NULL`, the out-of-fold
  predictions from the base models will be used.

- target:

  Target parameter vector that must be provided if predicting on a new
  data list. If `NULL`, the target vector used to train the base models
  will be used.

- metric:

  Metric for use with
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function.
  If `NULL`, default metric will be constructed depending on the target
  type.

- trControl:

  Control for use with the
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function.
  If `NULL`, a default control will be constructed depending on the
  target type. TODO hyperlink default arguments + add quick description

- ...:

  Additional arguments to pass to
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html)

## Value

A `caret_stack` object.
