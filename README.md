<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/CompBio-Lab/caretMultimodal/graph/badge.svg)](https://app.codecov.io/gh/CompBio-Lab/caretMultimodal)
[![R-CMD-check](https://github.com/CompBio-Lab/caretMultimodal/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CompBio-Lab/caretMultimodal/actions/workflows/R-CMD-check.yaml)
![Code Size](https://img.shields.io/github/languages/code-size/CompBio-Lab/caretMultimodal)

<!-- badges: end -->

# caretMultimodal

**caretMultimodal** builds on the [caret](https://github.com/topepo/caret) package to make it 
easy to train, combine, and interpret models from multiple datasets or modalities. The package implements a data integration technique called **late fusion**, where base models are trained 
independently on each dataset, and their predictions are then aggregated using an ensemble model.

This work is inspired by Zach Mayer's [caretEnsemble](https://github.com/zachmayer/caretEnsemble) package, 
which is used for stacking multiple models on a single dataset.

## Project Status

⚠️ **Work in Progress**

`caretMultimodal` is currently under active development. The API, functionality, and documentation may change as features are refined.

## Key Features

- Includes all the functionality of **caret**, giving users full control over sampling strategies, training methods, hyperparameter tuning, and more  
- Default cross-validation structure with careful handling to prevent data leakage across modalities  
- Late fusion ensembling using stacked generalization  
- Parallelization for faster training across models and datasets  
- Model trimming to reduce memory usage for large ensembles  
- Built-in evaluation tools for performance assessment, ROC curves, and variable importance  
- Detailed error messages to simplify debugging

## Installation

The package can be installed using devtools

``` r
devtools::install_github("CompBio-Lab/caretMultimodal")
```
