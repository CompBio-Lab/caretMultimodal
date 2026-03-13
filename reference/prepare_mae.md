# Prepare a MultiAssayExperiment for use with caretMultimodal

Converts a MultiAssayExperiment object from the MultiAssayExperiment
package to a simple list of datasets to pass into `caret_list`.

## Usage

``` r
prepare_mae(mae, transpose = FALSE, ...)
```

## Arguments

- mae:

  The MultiAssayExperiment object.

- transpose:

  Whether to transpose the individual matrices. Samples must correspond
  to rows for caret_list. Default is FALSE.

- ...:

  Not used. Included for S3 compatibility.

## Value

A named list of matrices.
