#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#total emission
total<-with(pm25, aggregate(Emissions, list(total=year), "sum"))

#plot
png("./plot1.png")
plot(total, type = "b", xlab = "Year", 
     main = "Total PM2.5 emission in US from 1999 to 2008", 
     ylab = "Total PM2.5 Emission (ton)")
dev.off()