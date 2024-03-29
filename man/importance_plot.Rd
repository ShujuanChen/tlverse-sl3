% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/importance.R
\name{importance_plot}
\alias{importance_plot}
\title{Variable Importance Plot}
\usage{
importance_plot(x, nvar = min(30, nrow(x)))
}
\arguments{
\item{x}{The two-column \code{data.table} returned by
\code{\link{importance}}, where the first column is the covariate/groups
and the second column is the importance score.}

\item{nvar}{The maximum number of predictors to be plotted. Defaults to the
minimum between 30 and the number of rows in \code{x}.}
}
\value{
A \code{\link[ggplot2]{ggplot}} of variable importance.
}
\description{
Variable Importance Plot
}
\examples{
# define ML task
data(cpp_imputed)
covs <- c("apgar1", "apgar5", "parity", "gagebrth", "mage", "meducyrs")
task <- sl3_Task$new(cpp_imputed, covariates = covs, outcome = "haz")

# build relatively fast learner library (not recommended for real analysis)
lasso_lrnr <- Lrnr_glmnet$new()
glm_lrnr <- Lrnr_glm$new()
ranger_lrnr <- Lrnr_ranger$new()
lrnrs <- c(lasso_lrnr, glm_lrnr, ranger_lrnr)
names(lrnrs) <- c("lasso", "glm", "ranger")
lrnr_stack <- make_learner(Stack, lrnrs)

# instantiate SL with default metalearner
sl <- Lrnr_sl$new(lrnr_stack)
sl_fit <- sl$train(task)
importance_result <- importance(sl_fit)
importance_plot(importance_result)
}
\keyword{importance}
\keyword{variable}
