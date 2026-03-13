# Create a `caret_list` object

Build a list of
[`caret::train`](https://rdrr.io/pkg/caret/man/train.html) objects,
where each model corresponds to a data set in `data_list`. The resulting
list is structured for use in ensembling workflows. Users can specify
the training method, control parameters, and metrics, and the function
supports error handling and model trimming for efficiency.

## Usage

``` r
caret_list(
  target,
  data_list,
  method,
  identifier_column_name = NULL,
  trControl = NULL,
  metric = NULL,
  trim = TRUE,
  do_parallel = TRUE,
  ...
)
```

## Arguments

- target:

  Target parameter vector, either numeric for regression or a
  factor/character for classification.

- data_list:

  A list of data sets to train models on

- method:

  The method to train the models with. Can be a custom method or one
  found in
  [`caret::modelLookup()`](https://rdrr.io/pkg/caret/man/modelLookup.html).

- identifier_column_name:

  The name of a column that connects the rows in the dataset (ex. a
  participant ID). If provided, this column must be present in all
  datasets within the `data_list` for proper matching. Use this if the
  datasets have different numbers of rows.

  Currently, providing `identifier_column_name` disables support for
  custom `trControl`, because a new resampling scheme must be
  constructed for each dataset after row matching, which may invalidate
  user-supplied fold indices.

- trControl:

  Control for use with the
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function.
  If `NULL`, a default control will be constructed depending on the
  target type.

- metric:

  Metric for use with
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function.
  If `NULL`, a default metric will be constructed depending on the
  target type.

- trim:

  Logical, whether the train models be trimmed to save memory. Default
  is `TRUE`

- do_parallel:

  Logical, whether to parallelize model training across datasets.
  Default is `TRUE`

- ...:

  Additional arguments to pass to the
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function

## Value

A `caret_list` object, which is a list of
[`caret::train`](https://rdrr.io/pkg/caret/man/train.html) model
corresponding to `data_list`.
