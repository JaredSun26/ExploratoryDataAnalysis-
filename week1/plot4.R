#===============================================================================
# Exploratory Data Analysis Project #1 - Plot 4
# Author:  Byron Estes
# Date: 4/10/2015
#===============================================================================
#-------------------------------------------------------------------------------
# Step 1:  Download zip file to working direcory IF IT DOES NOT ALREADY EXIST
#-------------------------------------------------------------------------------

if(!file.exists("exdata-data-household_power_consumption.zip")) {
        print("downloading...")
        zipfile <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipfile)
} else {
        zipfile <- "exdata-data-household_power_consumption.zip" 
}

#-------------------------------------------------------------------------------
# Step 2:  Read the file needed from the archive (i.e. does not explode it) and 
#          load it into a data frame. 
#-------------------------------------------------------------------------------

hpc <- read.csv(unz(zipfile, "household_power_consumption.txt"), 
                header=TRUE, 
                sep =";", 
                na.strings="?",
                stringsAsFactors=FALSE)
                
#-------------------------------------------------------------------------------
# Step 3: Condition Data for graphing
#-------------------------------------------------------------------------------
# (a) Subset to data so that it only contains observations from 2/1/2007 and
#     2/2/2007.
#-------------------------------------------------------------------------------

hpc <- hpc[which(hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007"),]

#-------------------------------------------------------------------------------
# (b) Add a combined date/time variable to dataframe and coherce it to POSIXct
#-------------------------------------------------------------------------------

hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$DateTime <- as.POSIXct(hpc$DateTime, format="%d/%m/%Y %H:%M:%S")

#-------------------------------------------------------------------------------
# (c) Convert remaining non date and time columns to numeric.                  
#-------------------------------------------------------------------------------

hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
hpc$Voltage <- as.numeric(hpc$Voltage)
hpc$Global_intensity <- as.numeric(hpc$Global_intensity)
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering-3)

#-------------------------------------------------------------------------------
# Step 4: Plot graph 4 which is a 4 graph multi-plot to PNG device
#         Note:  I made it look "exactly" like the sample output in assignment
#         right down to what I consider "imperfections/discrepancies". :)
#               * No x-axis label on upper left graph, slight change in y-sxis
#                 label to remove units in parenthesis.
#               * No box around legend on lower left graph
#               * Ugly y=axis label with underscores on lower right graph 
#-------------------------------------------------------------------------------

png(filename="plot4.png",
    width=480,
    height=480)

par(mfcol = c(2,2))

#-------------------------------------------------------------------------------
# Plot Upper Left Corner - Sames as Plot 2
#-------------------------------------------------------------------------------

plot(hpc$DateTime, 
     hpc$Global_active_power, 
     type="l",
     ylab="Global Active Power",
     xlab="")
     
#-------------------------------------------------------------------------------
# Plot Lower Left Corner - Same as Plot 3 with exception of no border on legend.
#-------------------------------------------------------------------------------

plot(hpc$DateTime, 
     hpc$Sub_metering_1,
     type="l",
     ylab="Energy sub metering",
     xlab="") 

lines(hpc$DateTime, 
      hpc$Sub_metering_2,
      type="l",
      col="red")

lines(hpc$DateTime, 
      hpc$Sub_metering_3,
      type="l",
      col="blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       bty="n",
       lty=1)

#-------------------------------------------------------------------------------
# Plot Upper Right Corner - Line graph for Voltage
#-------------------------------------------------------------------------------

plot(hpc$DateTime, 
     hpc$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")
     
#-------------------------------------------------------------------------------
# Plot Lower Right Corner - Line graph for Global Reactive Power
#-------------------------------------------------------------------------------

plot(hpc$DateTime, 
     hpc$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

dev.off()
