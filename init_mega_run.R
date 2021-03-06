#Initialize mega runs

#mega run in computer lab
# install.packages('devtools')
# install.packages("sendmailR")

#--------------------------------------------------------------------------------------------
#Load Packages
library(devtools)
library(plyr)
library(dplyr)
library(reshape2)
library(ggplot2)
library(doParallel)
library(parallel)
library(foreach)
library(stringr)
library(sendmailR)

#--------------------------------------------------------------------------------------------
#Update directory

#Automatically detect # of cores
nncores <- detectCores() - 2

#Big Lab Mac
if(Sys.info()['sysname'] == 'Darwin' & nncores == 22){
  #Make sure to login to 
  results_dir <- "/Volumes/udrive/hlsimulator_runs"
  sys <- 'mac'
  nncores <- 20
  ##Make sure that udrive is functional
}

#My Laptop Mac
if(Sys.info()['sysname'] == 'Darwin' & nncores < 10){
  setwd("/Users/peterkuriyama/School/Research/hlsimulator")  
  type <- 'mac'
  results_dir <- "/Volumes/udrive/hlsimulator_runs"
}

#Whitefish
if(Sys.info()['sysname'] == 'Windows' & nncores == 10){
  results_dir <- "C://Users//Peter//Desktop//hlsimulator"
}

#Smaller Lab computers, save to UDRIVE
if(Sys.info()['sysname'] == 'Windows' & nncores < 10){
  # setwd("C://Users//Peter//Desktop//hlsimulator")
  results_dir <- "Z://hlsimulator_runs"
}

#Big Lab computer, save to UDRIVE
if(Sys.info()['sysname'] == 'Windows' & nncores > 11){
  nncores <- 20
  #Specify somehing here, I think it's U
  results_dir <- "U://hlsimulator_runs"
  sys <- 'pc'
}

#--------------------------------------------------------------------------------------------
#May need to track depletion by drop at some points, this is in conduct_survey
#--------------------------------------------------------------------------------------------
#From github straight
install_github('peterkuriyama/hlsimulator')
library(hlsimulator)

#----------------------------------------------------------------------------------------
# What range of catch per hooks provides a relative index of abundance?
# What range of hooks without an aggressive species provides a relative index of abundance.

#--------------------------------------------------------------------------------------------
#Define scenarios for all simulations
shape_list1 <- data.frame(scen = c('leftskew', 'rightskew', 'normdist', 'uniform', 'patchy'),
  shapes1 = c(10, 1, 5, 1, .1),
  shapes2 = c(1 , 10 ,5, 1, 10))
shape_list1$for_plot <- c('Left Skew', 'Right Skew', 'Symmetric', 'Uniform', 'Patchy')

#Only run for patchy and normal
# shape_list1 <- subset(shape_list1, scen %in% c('normdist', 'patchy'))

#Keep the same prob1 and prob2
ctl1 <- make_ctl(distribute = 'beta', mortality = 0, move_out_prob = .05, 
      nfish1 = 100000,
      nfish2 = 0, prob1 = .01, prob2 = .01, nyear = 1, scope = 0, seed = 1,
      location = data.frame(vessel = 1, x = 1, y = 1), numrow = 30, numcol = 30,
      shapes = c(.1, .1) , max_prob = 0, min_prob = 0, comp_coeff = .5, niters = 1, 
      nhooks = 5)   

#--------------------------------------------------------------------------------------------
#Functions to create to_loop values
#Function to that returns rounded numbers of fish1 at evenly spaced proportions
calc_fish1_prop <- function(nfish2, prop = seq(0, .9, .1)){
  fishes <- prop * nfish2 / (1 - prop)
  fishes <- round(fishes, digits = 0)
  return(fishes)
}

#Function to create to_loop data frame
create_to_loop <- function(fishes1, fishes2, comp_coeffs = c(.3, .5, .7),
  shape_rows = c(3, 5), nsites = 50){

  to_loop <- expand.grid(fishes1, fishes2, comp_coeffs, shape_rows, c('pref', 'rand'))
  names(to_loop) <- c('nfish1', 'nfish2', 'comp_coeff', 
    'shape_list_row', 'type')
  to_loop$nsites <- nsites
  to_loop$c1_sum <- .01
  return(to_loop)
}

#--------------------------------------------------------------------------------------------
#To loop Key
# 1 - leftskew
# 2 - rightskew
# 3 - normdist
# 4 - uniform
# 5 - patchy

#--------------------------------------------------------------------------------------------
#0 - 200,000 in increments of 20,000
fishes1 <- seq(0, 200000, by = 20000)
fishes2 <- seq(0, 200000, by = 20000)

to_loop <- create_to_loop(fishes1 = fishes1, fishes2 = fishes2)
#remove the rows with 0 and 0 for numbers of fish
to_loop <- to_loop[-which(to_loop$nfish1 == 0 & to_loop$nfish2 == 0), ]

#--------------------------------------------------------------------------------------------
#Only do 
to_loop <- create_to_loop(fishes1 = fishes1, fishes2 = fishes2, shape_rows = 4)
to_loop <- to_loop[-which(to_loop$nfish1 == 0 & to_loop$nfish2 == 0), ]

to_loop1 <- subset(to_loop, shape_list_row == 4)
to_loop <- to_loop1

#--------------------------------------------------------------------------------------------
#Hold fishes2 constant, and evaluate at values of fishes1
#such that proportion of species 1 is evenly spaced

to_loop1 <- create_to_loop(fishes2 = 60000, fishes1 = calc_fish1_prop(60000))
to_loop2 <- create_to_loop(fishes2 = 80000, fishes1 = calc_fish1_prop(80000))
to_loop3 <- create_to_loop(fishes2 = 100000, fishes1 = calc_fish1_prop(100000))

to_loop <- rbind(create_to_loop(fishes2 = 60000, fishes1 = calc_fish1_prop(60000)),
                 create_to_loop(fishes2 = 80000, fishes1 = calc_fish1_prop(80000)),
                 create_to_loop(fishes2 = 100000, fishes1 = calc_fish1_prop(100000)),
                 create_to_loop(fishes2 = 0, fishes1 = calc_fish1_prop(60000)),
                 create_to_loop(fishes2 = 0, fishes1 = calc_fish1_prop(80000)),
                 create_to_loop(fishes2 = 0, fishes1 = calc_fish1_prop(100000)))

# to_loop <- rbind(to_loop1, to_loop2, to_loop3)


#--------------------------------------------------------------------------------------------



