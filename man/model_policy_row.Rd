% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/questions.R
\name{model_policy_row}
\alias{model_policy_row}
\title{model policy row}
\usage{
model_policy_row(responses, model_name, policy_name = NA, notes = NA)
}
\arguments{
\item{responses}{a set of responses to the questions}

\item{model_name}{the model name associated with the responses}

\item{policy_name}{the scenario name associated with the resoponses}

\item{notes}{the comments set by the user associated with these responses}
}
\value{
a tibble with 1 row
}
\description{
build a single row of the overall table to ensure that all rows of the stored states are formatted consistently
}
