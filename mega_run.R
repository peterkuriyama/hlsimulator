#--------------------------------------------------------------------------------------------
#Check results
#Remove everything
rm(twospp)
rm(twospp1)

#Load stuff in
load(paste0(results_dir, '//',  'twospp1_newcc_check_5.Rdata'))
#Check results
head(twospp1)

#Now run big runs
#Number of repetitions is important
nreps <- 1000 

#Adjust number of reps
to_loop$nreps <- nreps

#Specify Index for each computer
#-----------------
#Mac
if(sys == 'mac') run_this_ind <- 1

#PC
if(sys == 'pc') run_this_ind <- 2

#-----------------
#Check Run Index
run_this_ind
#-----------------

#--------------------------------------------------------------------------------------------
#To Do for lab computers

#Create indices for each computer, plan is to do this on five computers
tot <- 1:nrow(to_loop)
tots <- split(tot, ceiling(seq_along(tot) / (nrow(to_loop) / 2)))

if(length(run_this_ind) == 1) to_run <- tots[[run_this_ind]]
if(length(run_this_ind) > 1){
  to_run <- unlist(tots[run_this_ind])
  names(to_run) <- NULL
} 

start_time <- Sys.time()

clusters <- parallel::makeCluster(nncores)
doParallel::registerDoParallel(clusters)

twospp <- foreach(ii = to_run,
  .packages = c('plyr', 'dplyr', 'reshape2', 'hlsimulator'), .export = c("shape_list1")) %dopar% {
    fixed_parallel(index = ii, ctl1 = ctl1, to_loop = to_loop, 
      change_these = c('nfish1', 'nfish2', 'comp_coeff'))  
}

#Close clusters
stopCluster(clusters)

#Record run time
run_time <- Sys.time() - start_time

#Format output
site_cpues <- lapply(twospp, FUN = function(x) x[[2]])
twospp <- lapply(twospp, FUN = function(x) x[[1]])

twospp <- ldply(twospp)  

if(length(run_this_ind) > 1) run_this_ind <- paste(run_this_ind, collapse = "")

assign(paste0("twospp", run_this_ind), twospp)
#From previous runs
# filename <- paste0("twospp", run_this_ind )

#Run now, run2
filename <- paste0("twospp", run_this_ind ) #for new competition coefficient

#Save output in U drive
#Name of c1_sum
c1_nm <- gsub("\\.", "", as.character(unique(to_loop$c1_sum)))
save(list = filename, file = paste0(results_dir, "//" , paste0(filename, "_newcc_", nreps, "_",
  c1_nm, "_date_", Sys.Date() , '.Rdata')))

#Send email that run is done
send_email(body = paste(paste('run', run_this_ind, 'done'), 
  '\n', run_time, units(run_time),  '\n'))

#Clear workspace for others
# rm(list = ls())
