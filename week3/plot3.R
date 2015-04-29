library(ggplot2)
library(dplyr)
#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#emission of Baltimore city only
pm25_BC<-filter(pm25,fips=="24510")%>% group_by(type,year)%>%summarise(totalEmissions=sum(Emissions))


#plot
png("plot3.png")
g<-ggplot(pm25_BC, aes(year, totalEmissions, color=type))
g+geom_line()
dev.off()
