% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/move_fish_loop.R
\name{move_fish_loop}
\alias{move_fish_loop}
\title{Move fish in for loop
Function that moves fish by looping through locations. Do this rather than apply statement
to avoid weird fish movement if nfish in a certain cell isn't enough.}
\usage{
move_fish_loop(location, ff, scope)
}
\arguments{
\item{location}{Data frame of locations}

\item{ff}{Fish area, called ff because I couldnt' think of a better name for it}
}
\description{
Move fish in for loop
Function that moves fish by looping through locations. Do this rather than apply statement
to avoid weird fish movement if nfish in a certain cell isn't enough.
}
