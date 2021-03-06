% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compare_three_surveys.R
\name{compare_three_surveys}
\alias{compare_three_surveys}
\title{Compare three surveys}
\usage{
compare_three_surveys(numrow = 10, numcol = 10, nfish = 1000, distribute,
  seed = 300, nyears = 15, location_list, random_locations = FALSE,
  nlocs = 10, move_func, nhooks, ndrops, scope = 0, pdf = FALSE,
  png = FALSE, ...)
}
\arguments{
\item{numrow}{Number of rows in matrix}

\item{numcol}{Number of columns in matrix}

\item{nfish}{Number of fish to allocate among matrix}

\item{distribute}{Specify fish distribution to be 'uniform', 'patchy', or 'area' specific}

\item{seed}{Set seed if distribute == random, defaults to 300}

\item{move_func}{input movement function name as text. Later parsed into function call}

\item{maxfish}{Maximum number of fish that can be sampled at a time}

\item{percent}{percentage of area to sample. Only necessary if distribute == 'patchy'}

\item{area}{Specify area to distribute fish, options are 'upperleft', 'upperright', 'lowerleft', 'lowerright',
'upperhalf', 'lowerhalf', 'righthalf', 'lefthalf' 
  Only necessary if distribute == 'area'}
}
\description{
Compare three surveys and plot the results
}
\examples{
Put example in 
}
\keyword{initialize}
