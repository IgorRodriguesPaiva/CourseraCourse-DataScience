# Write a function named 'pollutantmean' that calculates the mean of a 
#pollutant (sulfate or nitrate) across a specified list of monitors. 
#The function 'pollutantmean' takes three arguments: 
#'directory', 'pollutant', and 'id'. Given a vector monitor 
#ID numbers, 'pollutantmean' reads that monitors' particulate matter data
#from the directory specified in the 'directory' argument and returns the 
#mean of the pollutant across all of the monitors, ignoring any missing 
#values coded as NA.

pollutantmean <- function(directory, pollutant, index = 1:332){
    library(plyr)
    data_path <- paste0(getwd(),"/", directory)
    temp = list.files(path = data_path, pattern= ".csv")
    main_path <- getwd()
    setwd(data_path)
    dat_csv = ldply(temp, read.csv)
    dat_clean <- dat_csv[complete.cases(dat_csv),]
    dat_use <- subset(dat_clean, ID %in% index)
    
    if (pollutant == "nitrate"){
        mean_of_pollutant <- mean(dat_use[["nitrate"]])
        print("Mean of nitrate is:") 
        print(mean_of_pollutant)
    }
    
    else if(pollutant == "sulfate"){
        mean_of_pollutant <- mean(dat_use[["sulfate"]])
        print("Mean of sulfate is:") 
        print(mean_of_pollutant)
    }
    setwd(main_path)
}
