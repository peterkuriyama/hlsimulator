#' Exponential Fish Sampling
#' Function that samples based on exponential function. Catch probabilities depend on number
#' of fish and probabilities of catching each species. 

#'Function to fish the population
#'@param nfish1 Number of fish1
#'@param nfish2 Number of fish2
#'@param prob1 Probability of catching fish1
#'@param prob2 Probability of catching fish2

#'@examples
#' Put Example Here
#'@export

sample_exp <- function(nfish1, nfish2, prob1, prob2){

  #------------------------------------------------
  #Define probabilities based on number of fish

  #Might need to adjust the shape of this curve
  #Can adjust these to account for behavior of certain species
  p1 <- 1 - exp(-nfish1 * prob1) #use prob 1 to define probability of catching fish 1
  p2 <- 1 - exp(-nfish2 *  prob2) #use prob2 to define probability of catching fish 2

  #Probability of catching a fish
  hook_prob <- 1 - ((1 - p1) * (1 - p2))

#Some error with binomial arguments
  fish <- rbinom(n = 1, size = 1,  prob = hook_prob)
  
  #------------------------------------------------
  # Which fish was caught?
  #initially declare both as 0
  fish1 <- 0
  fish2 <- 0
  
  #If a fish was caught determine if it was fish1 or fish2
  if(fish == 1){
    p1a <- p1 / (p1 + p2)  
    fish1 <- rbinom(n = 1, size = 1, prob = p1a)
  }
  
  if(fish1 == 0 & fish == 1) fish2 <- 1
  
  #Return values as data frame
  return(data.frame(fish1 = fish1, fish2 = fish2))
  
}