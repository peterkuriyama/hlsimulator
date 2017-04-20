#--------------------------------------------------------------------------------------------
#Figure 1

#--------------------------------------------------------------------------------------------
#Plot Arguments
#REMOVE RIGHTSKEW
shape_list4 <- subset(shape_list1, scen != 'rightskew')

shape_list4$for_plot[2] <- 'Symmetric'

#Figure 1. Show distributions of each sceanrio
ctl1$nfish1 <- 60000

#Make table of values for initial distributions
letts <- c('a)', 'b)', 'c)', 'd)')

inits <- lapply(1:nrow(shape_list4), FUN = function(ss){
  ctl1$shapes <- c(shape_list4[ss, 2], shape_list4[ss, 3])
  temp <- initialize_population(ctl = ctl1, nfish = ctl1$nfish1)
  return(temp)
})

fish1s <- seq(20000, 200000, 20000)
inits_list <- vector('list', length(fish1s))

for(ff in 1:length(fish1s)){
  #Make Table of values also 
  #Format this figure
  inits1 <- lapply(1:nrow(shape_list4), FUN = function(ss){
    ctl1$shapes <- c(shape_list4[ss, 2], shape_list4[ss, 3])
    temp <- initialize_population(ctl = ctl1, nfish = fish1s[ff])
    return(temp)
  })
  
  inits2 <- lapply(inits1, FUN = function(x){
    c(median(x), min(x), max(x))
  })
  
  inits2 <- ldply(inits2)
  names(inits2) <- c('meds', 'mins', 'maxs')
  inits2$nfish <- fish1s[ff]
  inits2$scen <- shape_list4$scen

  inits_list[[ff]] <- inits2

}

inits_list <- ldply(inits_list)

inits_list$summ <- paste(inits_list$mins, round(inits_list$meds, digits = 0), inits_list$maxs, sep = " - ")
inits_list$abundance <- inits_list$nfish / max(inits_list$nfish)

table1 <- inits_list %>% select(abundance, nfish, scen, summ)
table1 <- table1 %>% dcast(abundance + nfish ~ scen, value.var = 'summ')
table1 <- table1 %>% select(abundance, nfish, leftskew, normdist, uniform, patchy)
names(table1) <- paste0(toupper(substr(names(table1), 1, 1)), 
  substr(names(table1), 2, nchar(names(table1))))
write.csv(table1, 'output/table1.csv', row.names = FALSE)

#--------------------------------------------------------------------------------------------
#Figure
#Should probably be a one column figure
png(width = 7, height = 7, units = 'in', res = 150, file = 'figs/hlfig1.png')

par(mfrow = c(2, 2), mar = c(0, 0, 0, 0), oma = c(4, 5, .5, 1), mgp = c(0, .7, 0))

for(ii in 1:length(inits)){
  temp <- inits[[ii]]
  hist(temp, breaks = seq(0, 2270, 5), main = shape_list1[ii, 'scen'], freq = FALSE, 
    xlim = c(0, 300), axes = F, ann = F, ylim = c(0, .14), yaxs = 'i', xaxs = 'i')
  box()
  mtext(letts[ii], side = 3, line = -1.7, adj = 0.01, cex = 1.25)
  mtext(shape_list4[ii, 'for_plot'], side = 3, line = -1.7, adj = .95, cex = 1.25)
  # mtext(paste0('mean = ', round(mean(temp), digits = 0)), side = 3, line = -3, adj = .95)
  mtext(paste0('median = ', round(median(temp), digits = 0)), side = 3, line = -3, adj = .95)
  mtext(paste0('range = ', range(temp)[1], ', ', range(temp)[2]), side = 3, line = -4, adj = .95)
  if(ii == 1) axis(side = 2, at = seq(0, 0.12, by = .02), labels = seq(0, 0.12, by = .02), las = 2, 
    cex.axis = 1.2)
  if(ii == 3){
    axis(side = 2, at = seq(0, 0.12, by = .02), labels = seq(0, 0.12, by = .02), las = 2, cex.axis = 1.2)
    axis(side = 1, at = seq(0, 250, by = 50), cex.axis = 1.2)
  } 
  if(ii == 4) axis(side = 1, cex.axis = 1.2)
}
mtext(side = 1, "Number of fish", outer = T, cex = 1.5, line = 2.5)
mtext(side = 2, "Proportion of sites", outer = T, cex = 1.5, line = 3)

dev.off()



