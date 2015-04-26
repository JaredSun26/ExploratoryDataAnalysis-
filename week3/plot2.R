#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#total emission in Baltimore
total_Baltimore<-with(pm25[pm25$fips=="24510",], aggregate(Emissions, list(total=year), "sum"))

#plot
png("./plot2.png")
plot(total_Baltimore, type = "b", xlab = "Year", 
     main = "Total PM2.5 emission in Baltimore City from 1999 to 2008", 
     ylab = "Total PM2.5 Emission (ton)")
dev.off()
