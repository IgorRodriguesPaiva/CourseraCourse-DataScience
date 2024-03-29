##Write a function that takes a directory of data files and a threshold for 
##complete cases and calculates the correlation between sulfate and nitrate for 
##monitor locations where the number of completely observed cases 
##(on all variables) is greater than the threshold. The function should return 
##a vector of correlations for the monitors that meet the threshold requirement. 
##If no monitors meet the threshold requirement, then the function should
##return a numeric vector of length 0. 

corr <- function(directory, threshold){
    library(plyr)
    corr_vect <- NULL
    aux_dataframe <- data.frame(NULL)
    
    data_path <- paste0(getwd(),"/", directory)
    temp = list.files(path = data_path, pattern= ".csv")
    main_path <- getwd()
    setwd(data_path)
    dat_csv = ldply(temp, read.csv)
    dat_clean <- dat_csv[complete.cases(dat_csv),]
    
    for (i in 1:332){
        aux_dataframe <- subset(dat_clean, ID == i)
            
        if (nrow(aux_dataframe) > threshold) {
            corr_vect <- c(corr_vect, cor(aux_dataframe[,"sulfate"], aux_dataframe[, "nitrate"]))
        }
    } 
    setwd(main_path)
    return(corr_vect)
}
