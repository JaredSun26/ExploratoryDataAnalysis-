library(dplyr)
library(ggplot2)
#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="data.zip")
unzip("./data.zip")
#read the dataset
pm25<- readRDS("./summarySCC_PM25.rds")
scc<- readRDS("./Source_Classification_Code.rds")

#emission of Baltimore city only
pm25_BC<-pm25[pm25$fips=="24510",]

temp<-pm25_BC %>% group_by(type, year) %>% summarize(total=sum(Emissions))
ggplot(temp, aes(year, total, color=type))+geom_line()
