library(ggplot2)

#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#find the scc corresponding to coal combustion
scc_motor<-scc[grep(pattern="motor", scc$Short.Name, ignore.case=TRUE), 1]

#find the pm25 emissions related with coal combustion
pm25_motor_BC<-pm25[pm25$SCC %in% scc_motor & pm25$fips=="24510",]

#plot
png("plot5.png")
g<-ggplot(pm25_motor_BC, aes(year, Emissions))
g+stat_summary(geom="line", fun.y="sum")+
  ylab("Total PM2.5 Emission (ton)")+
  ggtitle("Total PM2.5 emission from  motor vehicle source in Baltimore City")
dev.off()
