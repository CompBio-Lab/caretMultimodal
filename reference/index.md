# Package index

## Constructor and methods for `caret_list`

- [`caret_list()`](https://compbio-lab.github.io/caretMultimodal/reference/caret_list.md)
  :

  Construct a `caret_list` object

- [`predict(`*`<caret_list>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/predict.caret_list.md)
  :

  Predict from a `caret_list`

- [`oof_predictions(`*`<caret_list>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/oof_predictions.caret_list.md)
  :

  Out-of-fold predictions from a `caret_list`

- [`summary(`*`<caret_list>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/summary.caret_list.md)
  :

  Provide a summary of the best tuning parameters and resampling metrics
  for all the `caret_list` models.

## Constructor and methods for `caret_stack`

- [`caret_stack()`](https://compbio-lab.github.io/caretMultimodal/reference/caret_stack.md)
  :

  Construct a `caret_stack` object.

- [`predict(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/predict.caret_stack.md)
  :

  Create a matrix of predictions for a `caret_stack` object.

- [`oof_predictions(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/oof_predictions.caret_stack.md)
  : Out-of-fold predictions from a caret_stack

- [`summary(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/summary.caret_stack.md)
  :

  Get a summary of a `caret_stack` object

- [`plot_roc(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/plot_roc.caret_stack.md)
  : Plot ROC curves for individual and ensemble models in a caret_stack

- [`compute_metric(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/compute_metric.caret_stack.md)
  : Compute metrics with a provided metric function

- [`plot_metric(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/plot_metric.caret_stack.md)
  : Plot metrics computed with a provided metric function

- [`compute_model_contributions(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/compute_model_contributions.caret_stack.md)
  : Compute the relative contributions of each of the base models in the
  ensemble model

- [`plot_model_contributions(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/plot_model_contributions.caret_stack.md)
  : Plot the relative contributions of each of the base models in the
  ensemble model

- [`compute_ablation(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/compute_ablation.caret_stack.md)
  : Perform an ablation analysis for a caret_stack model.

- [`plot_ablation(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/plot_ablation.caret_stack.md)
  : Plot the results of an ablation analysis for a caret_stack model.

- [`compute_feature_contributions(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/compute_feature_contributions.caret_stack.md)
  : Compute the feature level contributions for a caret_stack model.

- [`plot_feature_contributions(`*`<caret_stack>`*`)`](https://compbio-lab.github.io/caretMultimodal/reference/plot_feature_contributions.caret_stack.md)
  : Plot the feature level contributions to a stacked model

## Miscellaneous Helper Functions

- [`prepare_mae()`](https://compbio-lab.github.io/caretMultimodal/reference/prepare_mae.md)
  : Prepare a MultiAssayExperiment for use with caretMultimodal

## Datasets

- [`heart_failure_datasets`](https://compbio-lab.github.io/caretMultimodal/reference/heart_failure_datasets.md)
  : Heart Failure Datasets

- [`heart_failure_stack`](https://compbio-lab.github.io/caretMultimodal/reference/heart_failure_stack.md)
  :

  Pre-trained `caret_stack` on Heart Failure Datasets
