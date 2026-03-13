# Compute the feature level contributions for a caret_stack model.

Feature-level contributions for the ensemble model are computed using a
two-stage application of caret::varImp. First, varImp is applied to the
ensemble model, where the base-model predictions are treated as
features, yielding dataset-level weights. Next, varImp is applied to
each base model to obtain feature-level importance scores within each
dataset. The final contribution of an individual feature to the ensemble
is calculated as the product of its dataset-level weight and its
feature-level importance within the corresponding base model.

## Usage

``` r
# S3 method for class 'caret_stack'
compute_feature_contributions(object, n_features = 20, ...)
```

## Arguments

- object:

  A `caret_stack` object.

- n_features:

  The maximum number of features to include. Setting to a very large
  value will include all features. Default is 20.

- ...:

  Not used. Included for S3 compatibility.

## Value

A `data.table`
