% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conduct_survey.R
\name{conduct_survey}
\alias{conduct_survey}
\title{Conduct Survey
Wrapper to repeatedly run fish_population function
Give function arguments for
This function initializes the spatial distribution of the fish population}
\usage{
conduct_survey(init_area, ...)
}
\arguments{
\item{init_area}{list of intialized areas}

\item{...}{arguments from other thing}
}
\description{
Conduct Survey
Wrapper to repeatedly run fish_population function
Give function arguments for
This function initializes the spatial distribution of the fish population
}
\examples{

ctl <- make_ctl()
conduct_survey(ctl)
}
\keyword{survey}
