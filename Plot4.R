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

## Plot 4:
png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

with(FinalData, plot(Date_Time, Global_active_power, 
                     type="l", col="black", xlab="", 
                     ylab="Global Active Power (kilowatts)"))

with(FinalData, plot(Date_Time, Voltage, 
                     type="l", col="black", xlab="datetime", 
                     ylab="Voltage"))

plot(finalData$SetTime, finalData$Sub_metering_1, type="l", 
     col="black", xlab="", ylab="Energy sub metering")
lines(finalData$SetTime, finalData$Sub_metering_2, col="red")
lines(finalData$SetTime, finalData$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lty="solid", bty = "n")

with(FinalData, plot(Date_Time, Global_reactive_power, 
                     type="l", col="black", xlab="datetime", 
                     ylab="Global_reactive_power"))
dev.off()
 
