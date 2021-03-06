% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_locs_2spp.R
\name{run_locs_2spp}
\alias{run_locs_2spp}
\title{Loop over locations with two species
Function to loop over locations with two species}
\usage{
run_locs_2spp(shape_list, ncores, ctl_o, thing1, name1, thing2, name2, nreps,
  par_func = "change_two", index1 = FALSE, index2 = FALSE,
  loc_scenario = "rand", fixed_locs = NA, nsites)
}
\arguments{
\item{shape_list}{Shape Scenarios to run, must specify}

\item{ncores}{Number of cores}

\item{ctl_o}{Original ctl list}

\item{thing1}{Thing1 to loop over, see change_two function}

\item{name1}{Name of thing1 to loop over, see change_two function}

\item{thing2}{Thing2 to loop over, see change_two function}

\item{name2}{Name of thing2 to loop over, see change_two function}

\item{nreps}{Number of replicates}

\item{loc_scenario}{Fixed, 'rand' or 'pref'}

\item{fixed_locs}{Fixed sampling locations}

\item{nsites}{Number of sites to sample}

\item{fixed_locs}{Fixed sampling locations}
}
\description{
Loop over locations with two species
Function to loop over locations with two species
}
