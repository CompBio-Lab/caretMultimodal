# Heart Failure Datasets

A multimodal dataset from Singh et al. (2019) containing demographic,
cellular, electrophysiological, and molecular features for predicting
cardiac-related hospitalizations. Used in examples throughout the
caretMultimodal package.

## Usage

``` r
heart_failure_datasets
```

## Format

A named list with 5 elements:

- demo:

  A `data.frame` of demographic features

- cells:

  A `data.frame` of cell count features

- holter:

  A `data.frame` of Holter monitor (ECG) features

- mrna:

  A `data.frame` of mRNA expression features

- proteins:

  A `data.frame` of protein abundance features

## Source

Singh et al. Ensembling Electrical and Proteogenomics Biomarkers for
Improved Prediction of Cardiac-Related 3-Month Hospitalizations: A Pilot
Study. *Can J Cardiol.* 2019 Apr.
[doi:10.1016/j.cjca.2018.11.021](https://doi.org/10.1016/j.cjca.2018.11.021)
