## Downloading and Saving data:
setwd("C:/Users/igorp/Documents/Courses/DataScience Course - Coursera/04 - Exploratory Data Analysis")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "household_power_consumption.zip"
householdFile <- "household_power_consumption.txt"

if (!file.exists(householdFile)) {
    download.file(URL, downloadFile, method = "curl")
    unzip(downloadFile, overwrite = TRUE, exdir = "./04 - Exploratory Data Analysis")
}

## Reading the data:
dataset <- read.delim("household_power_consumption.txt", header = TRUE,
                      sep = ";", na.strings = "?")

## Separating the data interval we need:
FinalData <- dataset[dataset$Date %in% c("1/2/2007","2/2/2007"),]

## Merging date and time columns:
DateAndTime <- paste(FinalData$Date, FinalData$Time, sep = " ")
Date_Time <- strptime(DateAndTime, format = "%d/%m/%Y %H:%M:%S")
FinalData <- cbind(Date_Time, FinalData)
FinalData <- FinalData[-c(2,3)]

## Plot 1:
png(filename = "Plot1.png")
hist(FinalData$Global_active_power, col = "red",
        main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)")
dev.off()
