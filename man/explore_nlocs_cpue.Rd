% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/explore_nlocs_cpue.R
\name{explore_nlocs_cpue}
\alias{explore_nlocs_cpue}
\title{Conduct survey at nlocaitons and save cpue for each drop}
\usage{
explore_nlocs_cpue(numrow, numcol, nfish, seed = 300, numlocs = 100,
  distribute, percent, scope = 1, nhooks = 15, ndrops = 5, ...)
}
\arguments{
\item{numrow}{number of rows to include in fishing space}

\item{numcol}{number of columns to include in fishing space}

\item{nfish}{number of fish to populate matrix}

\item{seed}{set seed for sampling}

\item{numlocs}{number of locations to fish in. default to 100}

\item{distribute}{specify fish distribution, 'patchy', 'uniform', or 'area'}

\item{percent}{percentage of fish to populate}

\item{scope}{the scope of fishing movement, default to 1 so fish in surrounding 1 cells can move in}

\item{nhooks}{number of hooks at the smallest sampling size}

\item{ndrops}{number of drops, default is 5 following hook and line protocol}

\item{location_list}{list specifying rows and columns to survey in}
}
\description{
Exploratory function more than anything
}
\examples{
put example here 

}
\keyword{analysis}
\keyword{exploratory}
