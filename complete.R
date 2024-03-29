
#Write a function that reads a directory full of files and reports the number 
#of completely observed cases in each data file. The function should return a 
#data frame where the first column is the name of the file and the second column
#is the number of complete cases. A prototype of this function follows

complete <- function(directory, index = 1:332){
    library(plyr)
    data_path <- paste0(getwd(),"/", directory)
    temp = list.files(path = data_path, pattern= ".csv")
    main_path <- getwd()
    setwd(data_path)
    dat_csv = ldply(temp, read.csv)
    dat_clean <- dat_csv[complete.cases(dat_csv),]
    dat_use <- subset(dat_clean, ID %in% index)
    dat_complete <- count(dat_use, "ID")
    cols <- c("id","nobs")
    colnames(dat_complete) <- cols
    print(dat_complete)
    setwd(main_path)
} 
