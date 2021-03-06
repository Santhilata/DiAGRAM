% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_table_module.R
\name{add_edit_column}
\alias{add_edit_column}
\title{add edit column}
\usage{
add_edit_column(df, ns, ...)
}
\arguments{
\item{df}{original tibble to add an edit column to}

\item{ns}{shiny namespace object}

\item{...}{currently unused, additional arguments passed on to internal methods}
}
\value{
a tibble
}
\description{
Add a column with an edit button to a tibble, attaching a namespaced shiny input event
for listening to the click
}
