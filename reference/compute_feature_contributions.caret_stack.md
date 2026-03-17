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

## Examples

``` r
# Load pre-trained example caret_stack object
data(heart_failure_stack)

compute_feature_contributions(heart_failure_stack)
#>        Model              Feature Relative Contribution
#>       <char>               <char>                 <num>
#>  1:   holter HS_HR_AVE_DayToNight             41.585315
#>  2:     mrna                 TLR7              7.210145
#>  3:     mrna                 PRLR              5.048845
#>  4:     mrna               FLVCR2              4.168204
#>  5: proteins                ITIH2              4.114475
#>  6:   holter    HR_SECONDS_MAX_RR              2.516984
#>  7:     mrna               SLC8A1              2.398912
#>  8:     mrna              RETREG1              2.088714
#>  9:     mrna                 TTC9              2.064062
#> 10: proteins                  PLG              1.965363
#> 11:     mrna                FOLR2              1.749651
#> 12:     mrna                 SVBP              1.738274
#> 13:     mrna                 NT5E              1.614556
#> 14:     mrna                 ERFE              1.390788
#> 15: proteins                 PON3              1.248055
#> 16: proteins                  B2M              1.200775
#> 17: proteins             SERPINA4              1.065383
#> 18: proteins                 CST3              1.047414
#> 19: proteins                 ANGT              1.039845
#> 20:     mrna             ANKRD36B              1.029405
#>        Model              Feature Relative Contribution
#>       <char>               <char>                 <num>
```
