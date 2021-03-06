% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/initialize_population_prob.R
\name{initialize_population_prob}
\alias{initialize_population_prob}
\title{Initialize Population Probabilities}
\usage{
initialize_population_prob(ctl)
}
\arguments{
\item{ctl}{List of control parameters from make_ctl function, description of arguments in 
make_ctl function}

\item{nfish}{Number of fish, use this to generate matrices for both species}
}
\description{
Initialize the spatial distribution of the fish population, units are probabilities. Used to select
sites for simulations with two species.
}
