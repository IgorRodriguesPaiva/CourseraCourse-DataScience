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

## Selecting Baltimore data:
NEIBaltimore <- subset(NEI, fips == "24510")

require(ggplot2)

## Calculating total emissions per year and type:
pollTotal <- aggregate(Emissions ~ year + type, NEIBaltimore, sum)

## Oppening file and saving the plot:
png(filename = "Plot3.png", width = 480, height = 480)
plot3 <- ggplot(data = pollTotal, aes(x = year, y = Emissions, color = type)) + 
            geom_line(size = 2) +
            labs(y = "Total PM2.5 Emissions [ton]",
             x = "Year",
             title = "Total Baltimore PM2.5 Emissions from 1999 to 2008")
plot3

dev.off()