# Construct a `caret_stack` object.

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
  trControl = NULL,
  metric = NULL,
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
  predictions from the base models will be used. Default is `NULL`.

- target:

  Target parameter vector that must be provided if predicting on a new
  data list. If `NULL`, the target vector used to train the base models
  will be used.

- trControl:

  Control for use with the
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function.
  If `NULL`, `.default_control()` is used to construct a default control
  (5-fold cross validation) depending on the target type. Default is
  `NULL`.

- metric:

  Metric for use with
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function.
  If `NULL`, `.default_metric()` is used to construct a default metric
  depending on the target type. Default is `NULL`.

- ...:

  Additional arguments to pass to
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html)

## Value

A `caret_stack` object.

## Examples

``` r
set.seed(42)

data(heart_failure_datasets)

data_list <-  heart_failure_datasets[c("cells", "holter", "mrna", "proteins")]

# Define hyperparameters to tune (optional)
tuneGrid <- expand.grid(alpha = 0.5, lambda = c(0.01, 0.1))

# Construct caret_list object
base_models <- caret_list(
  target = heart_failure_datasets$demo$hospitalizations,
  data_list = data_list,
  method = "glmnet",
  tuneGrid = tuneGrid
)

# Train a Random Forest stacked model on the out-of-fold predictions from the base models
stacked_model <- caret_stack(
  caret_list = base_models,
  method = "rf"
)

class(stacked_model)
#> [1] "caret_stack"
```
