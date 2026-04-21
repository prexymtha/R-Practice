---
title: "Anscombe's Quartet: Visualising the Limits of Summary Statistics"
author: "Precious Nhamo"
date: "`r Sys.Date()`"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(
  echo      = TRUE,
  message   = FALSE,
  warning   = FALSE,
  fig.align = "center",
  fig.width = 5,
  fig.height = 4
)
```

# Overview

This document reproduces and extends the canonical demonstration from Anscombe (1973), showing that four datasets with identical summary statistics can have fundamentally different underlying structures. It is a foundational exercise in applied econometrics: summary statistics alone are insufficient for model evaluation -- visualisation is indispensable.

> "The simple graph has brought more information to the data analyst's mind than any other device."
> -- John W. Tukey (1962)

**Source:** Dayal, V. (2020). *Quantitative Economics with R*. Springer Nature Singapore. Chapter 4.

---

# Setup

```{r libraries}
source("code/anscombe_quartet_regression_and_visualisation.R")
```

---

# Data

Anscombe's Quartet (`datasets::anscombe`, built into R) consists of four (x, y) pairs -- 11 observations each -- constructed to share nearly identical descriptive statistics.

```{r load-data}
glimpse(anscombe_df)
```

---

# Summary Statistics

All four datasets share the same means, standard deviations, and regression coefficients. This is the central puzzle Anscombe (1973) set out to illustrate.

```{r summary-stats}
anscombe_summary 
```

# Regression Models

Four separate OLS models are fitted, one for each (x, y) pair.


```{r regression-table, results='asis'}
modelresults
```

Despite four structurally different datasets, every model returns an intercept of 3.00, a slope of 0.50, and an R-squared of 0.67. Regression output alone is uninformative about the true data-generating process.

---

# Visualisation

## Dataset 1 -- Linear relationship

The true relationship is linear. OLS assumptions are satisfied: residuals are approximately normally distributed with constant variance. The fitted line is an appropriate model.

```{r plot1}
plot_x1_y1 
```

## Dataset 2 -- Nonlinear (quadratic) relationship

The underlying relationship is quadratic, not linear. The OLS fit masks systematic curvature -- residuals follow a clear arc. R-squared = 0.67 is misleading here; a polynomial model (y ~ x + x^2) would be far more appropriate. This violates the linearity assumption.

```{r plot2}
plot_x2_y2 
```

## Dataset 3 -- Outlier / high-influence point

The relationship is linear except for one high-influence outlier at (x = 13, y = 12.74). This single point pulls the OLS slope upward and inflates R-squared. Without it, the fit would be near-perfect with a different slope. Cook's distance would flag this point immediately.

```{r plot3}
plot_x3_y3 
```

## Dataset 4 -- Leverage point

Ten observations share x = 8 (no variation in the regressor), while one point sits at x = 19. That single leverage point entirely determines the regression slope. There is no meaningful linear relationship -- the coefficient is an artefact of one observation, not a structural feature of the data.

```{r plot4}
plot_x4_y4 
```

---

# Key Finding

OLS regression and univariate summary statistics are not sufficient diagnostics for model adequacy. All four models produce identical coefficients and R-squared values, yet only Dataset 1 satisfies the classical OLS assumptions (linearity, homoscedasticity, no influential observations). This result motivates residual analysis, leverage diagnostics, and -- above all -- graphical inspection as standard practice in quantitative research.

---

# References

Anscombe, F. J. (1973). Graphs in statistical analysis. *The American Statistician*, 27(1), 17--21.

Dayal, V. (2020). *Quantitative Economics with R*. Springer Nature Singapore.

Leifeld, P. (2013). texreg: Conversion of statistical model output in R to LaTeX and HTML tables. *Journal of Statistical Software*, 55(8), 1--24.

Tukey, J. W. (1962). The future of data analysis. *Annals of Mathematical Statistics*, 33(1), 1--67.

Wickham, H., et al. (2017). *tidyverse: Easily install and load the tidyverse*. R package version 1.2.1.

