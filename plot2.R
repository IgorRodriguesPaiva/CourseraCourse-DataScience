## Downloading and Saving data:
setwd("C:/Users/igorp/Documents/Courses/DataScience Course - Coursera/04 - Exploratory Data Analysis/FinalProject")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
downloadFile <- "exdata_data_NEI_data.zip"
dataFile <- "exdata_data_NEI_data"

if (!file.exists(dataFile)) {
    download.file(URL, downloadFile, method = "curl")
    unzip(downloadFile, overwrite = TRUE, exdir = getwd())
}

## Reading data:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Selecting Baltimore data:
NEIBaltimore <- subset(NEI, fips == "24510")

## Calculating total emissions in Baltimore:
pollTotal <- with(NEIBaltimore, tapply(Emissions/1000, year, sum))
xcoordanates <- barplot(pollTotal)

## Oppening file and saving the plot:
png(filename = "Plot2.png", width = 480, height = 480)

barplot(pollTotal, main = "Total PM2.5 Emissions per Year in Baltimore",
        col = c("red","blue","green","yellow"), 
        ylab = "Total PM2.5 emission in Baltimore in kilotons",
        xlab = "Year",
        pch = 20, ylim = c(0, 4))
text(x = xcoordanates, y = pollTotal, labels = round(pollTotal,2), pos = 3,
     cex = 0.8)

dev.off()
