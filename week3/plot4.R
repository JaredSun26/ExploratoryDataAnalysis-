library(ggplot2)

#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#find the scc corresponding to coal combustion
scc_coal<-scc[grep(pattern="coal", scc$Short.Name, ignore.case=TRUE), 1]

#find the pm25 emissions related with coal combustion
pm25_coal<-pm25[pm25$SCC %in% scc_coal,]

#plot
png("plot4.png")
g<-ggplot(pm25_coal, aes(year, Emissions))
g+stat_summary(geom="line", fun.y="sum")+
  ylab("Total PM2.5 Emission (ton)")+
  ggtitle("Total PM2.5 emission from coal combustion-related sources from 1999 to 2008")
dev.off()

