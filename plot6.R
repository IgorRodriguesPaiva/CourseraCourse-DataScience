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

## Selecting Baltimore and Los Angeles data:
NEIBaltAng <- subset(NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

require(ggplot2)

## Creating the data.frame with all the information we need for the plot:
pollTotalBaltAng <- aggregate(Emissions ~ year + fips, NEIBaltAng, sum)
colnames(pollTotalBaltAng) <- c("Year","City","Emissions")
pollTotalBaltAng$City[pollTotalBaltAng$City == "24510"] <- "Baltimore"
pollTotalBaltAng$City[pollTotalBaltAng$City == "06037"] <- "Los Angeles"

## Oppening file and saving the plot:
png(filename = "Plot6.png", width = 480, height = 480)

plot6 <- ggplot(pollTotalBaltAng, aes(fill = City, y = Emissions, x = as.factor(Year), label = round(Emissions,2))) + 
         geom_bar(position ="dodge", stat ="identity") +
         geom_text(aes(label = round(Emissions,2), ), vjust=-0.5) +
         xlab("Year") +
         ylab("Total PM2.5 Emissions [tons]") +
         ggtitle("Emissions from motor vehicle sources in Baltimore and Los Angeles") +
         coord_cartesian(ylim = c(0,5000))
plot6

dev.off()