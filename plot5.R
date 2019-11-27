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
NEIBaltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")

require(ggplot2)

##Calculating total emissions per year:
pollTotal <- aggregate(Emissions ~ year, NEIBaltimore, sum)

## Oppening file and saving the plot:
png(filename = "Plot5.png", width = 480, height = 480)
plot5 <- ggplot(data = pollTotal, 
                aes(x = factor(year), y = Emissions, fill = Emissions, label = round(Emissions,2))) + 
                geom_bar(stat = "identity") +
                labs(y = "Total Emissions [ton]",
                     x = "Year",
                     title = "Total Baltimore Emissions PM2.5 from motor vehicle sources per Year") +
                geom_label(aes(fill = Emissions),colour = "white", fontface = "bold")
plot5

dev.off()
