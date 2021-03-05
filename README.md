# The-Trade-Off-Between-Accuracy-and-Interpretability

Interpretability is important because the higher the interpretability of a model, the easier it is to understand why decisions or predictions were made (Molnar, 2020).
Model interpretability addresses issues related to trust, informativeness, fairness and ethical decision making (Lipton, 2017).
For these reasons, interpretability is particularly relevant for high risk domains.

More complex and opaque models many times exhibit high accuracy, while more interpretable models may lack the necessary accuracy.
Consequently, new methods have been explored to address this tension in both the frequentist and the Bayesian fields.
On the frequentist approach, Lundberg and Lee (2017) introduced the SHapley Additive exPlanations (SHAP) framework for interpreting predictions by assigning each feature
an importance value for a particular prediction.
On the Bayesian framework, on the other hand, a method for interpretability was recently introduced by Afrabandpey, et. al. (2020). The authors proposed a general
principle for interpretability based, first, on building a highly accurate and, second, using an interpretable proxy model to explain the predictive model. It is worth mentioning that
the use of simple models as interpretable surrogates to highly predictive black-box models has been a common practice in Machine Learning. However, this approach has
poorly been explored in the Bayesian framework (Afrabandpey, et. al., 2020).

Even though there is no consensus on the definition of interpretability and its scope, for the purpose of this project, the concepts of global and local interpretability as defined by
Molnar, C. (2020) apply:
- global interpretability refers to the “understanding of how the model makes decisions, based on a holistic view of its features and each of the learned components”.
- local interpretability examines “what and why the model makes a certain prediction for a single instance.”
Finally, the performance metrics will be excluded from the local interpretability results since they are not differential to any model since they can always be obtained.

**Problem Statement:**
Interpretability is most relevant in high-impact domains. Consequences derived from poor interpretability are lack of advancement of knowledge in the field, credibility and
error identification. Thus, it is key to optimize the trade-off between accuracy and interpretability.
This project explores the interpretability of predictive models that are generally classified as high accuracy models in both the Frequentist and the Bayesian frameworks.

**Problem Elaboration:**
To explore the interpretability of a model generally classified as high accuracy, an ensemble method will be compared to a regression model.
In the frequentist framework, an ensemble model will be further explained with SHAP. In the Bayesian framework, the ensemble model trained is BART, acronym for the
Bayesian Additive Regression Trees.
The high impact domain chosen is healthcare; and the dataset used is the Breast Cancer Wisconsin. The target is the diagnosis of the tumor: benign or malignant.
The project is partially based on previous work where the dataset was preprocessed, 5 out of thirty features were selected and six models of the frequentist framework were
optimized by hyperparameter tuning.

**Conclusions:**

Frequentist Framework:
In the frequentist framework, Shapley Additive Explanations (SHAP) proved to be a powerful method to increase interpretability of opaque models, in this case, ensemble
methods.
The main advantage of SHAP is that it provides an intuition about feature importance. For instance, in this project, area_worst seems to be the most relevant feature whereas
area_mean is the least. However, the SHAP values are not meaningful because they do not provide traceability to the probability.

Bayesian Framework:
The main advantage of the Bayesian framework is that it provides posterior distributions that give the following three pieces of information.
First, the statistical significance of the features: according to the Bayesian Logistic Regression model implemented in this project, area_mean seems to be not statistically
significant because its 95% High Density Function (HDI) is distributed around zero, suggesting that the value of area_mean might be given by chance. The rest of the
features are statistically significant.
Second, a ranking of confidence in the predictive power of the features: according to the Bayesian Logistic Regression model, area_worst has the narrowest 95% HDI, thus it is
the first feature in the ranking of confidence. A narrow HDI indicates certainty about the values of the beta coefficients.
Finally, meaningful beta coefficients that provide traceability between the change in the probability and the change in the feature values.
Nonetheless, it is worth mentioning that this information is not available via an off-theshelf method to interpret opaque models in the Bayesian framework, as is the case with
the Bayesian Additive Regression Trees (BART).
