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

## Selecting coal combustion data:
coalCombustion <- SCC[grep("^Fuel Comb(.*)Coal", SCC$EI.Sector, ignore.case = T),]
coalCombustionList <- coalCombustion$SCC
coalComData <- subset(NEI, SCC %in% coalCombustionList)

##Calculating total emissions per year:
pollTotal <- aggregate(Emissions ~ year, coalComData, sum)
pollTotal$Emissions <- pollTotal$Emissions/1000

## Oppening file and saving the plot:
png(filename = "Plot4.png", width = 480, height = 480)
plot4 <- ggplot(data = pollTotal,
            aes(x = factor(year), y = Emissions, fill = Emissions, 
                label = round(Emissions, 2))) +
            geom_bar(stat = "identity", width = 0.7) +
            coord_cartesian(ylim = c(0,650)) +
            labs(y = "Total PM2.5 Emissions [kilotons]",
            x = "Year",
            title = "Emissions from coal combustion-related sources by Year") +
            geom_label(aes(fill = Emissions), colour = "white", fontface = "bold")
plot4

dev.off()