# Construct a `caret_list` object

Builds a list of
[`caret::train`](https://rdrr.io/pkg/caret/man/train.html) objects,
where each model corresponds to a data set in `data_list`. The resulting
list is used as input to
[`caret_stack()`](https://compbio-lab.github.io/caretMultimodal/reference/caret_stack.md)
to construct a meta model.

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

  Target vector, either numeric for regression or a factor/character for
  classification.

- data_list:

  A named list of matrix-like objects, where each element is a dataset
  to train a separate model on. Names are preserved in the returned
  `caret_list` and should be unique.

- method:

  The method to train the models with. Can be a custom method or one
  found in
  [`caret::modelLookup()`](https://rdrr.io/pkg/caret/man/modelLookup.html).

- identifier_column_name:

  A string giving the name of a column that links rows across datasets
  (e.g. a participant ID). If provided, this column must be present in
  all datasets in `data_list` for proper row matching. Use this when
  datasets have different numbers of rows. If `NULL`, datasets are
  assumed to have identical rows in the same order. Default is `NULL`.

  **Note:** Providing `identifier_column_name` disables support for
  custom `trControl`. A new resampling scheme must be constructed for
  each dataset after row matching, which may invalidate user-supplied
  fold indices.

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

- trim:

  Logical, whether the trained models should be trimmed to save memory.
  Default is `TRUE`.

- do_parallel:

  Logical, whether to parallelize model training across datasets.
  Default is `TRUE`.

- ...:

  Additional arguments to pass to the
  [`caret::train`](https://rdrr.io/pkg/caret/man/train.html) function
  (e.g. `tuneGrid = tuneGrid`).

## Value

A `caret_list` object (a named list of trained
[`caret::train`](https://rdrr.io/pkg/caret/man/train.html) models
corresponding to `data_list`).

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
#> Loading required package: ggplot2
#> Loading required package: lattice

class(base_models)
#> [1] "caret_list" "list"      
```
