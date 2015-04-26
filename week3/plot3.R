library(ggplot2)
#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#emission of Baltimore city only
pm25_BC<-pm25[pm25$fips=="24510",]

#plot
png("plot3.png")
g<-ggplot(pm25_BC, aes(year, Emissions, color=type))
g+stat_summary(geom="line", fun.y="sum")+
  ylab("Total PM2.5 Emission (ton)")+
  ggtitle("Total PM2.5 emission in Baltimore City from 1999 to 2008")
dev.off()
