library(datasets)
library(gsubfn)
library(plyr)
library(reshape2)
library(jpeg)
library(RCurl)
library(Hmisc)
library(lubridate)
install.packages("stringr", repos='http://cran.us.r-project.org')
library(stringr)

# Zip file located here:https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip. 
# Download and extract household_power_consumption.txt file to your system.

datasetdownload = "./household_power_consumption.txt"
selectdataset <- read.table (datasetdownload, header = TRUE, sep = ";")
selectdataset$Date <- as.Date(selectdataset[,1], format= "%d/%m/%Y")
refineddata <- selectdataset[selectdataset$Date == "2007-02-01",]
refineddata <- rbind(refineddata,selectdataset[selectdataset$Date == "2007-02-02",])
refineddata$Global_active_power <- as.numeric(refineddata$Global_active_power)
refineddata$Sub_metering_1 <- as.numeric(refineddata$Sub_metering_1)
refineddata$Sub_metering_2 <- as.numeric(refineddata$Sub_metering_2)
refineddata$Sub_metering_3 <- as.numeric(refineddata$Sub_metering_3)
newcol <- as.POSIXct(paste(refineddata$Date,refineddata$Time))
refineddata <- cbind(refineddata,newcol)

# Plot Graph

with(refineddata, plot(newcol, Global_active_power, ylab="Global Active Power (kilowatts)",yaxt="n",type="l",xlab=""))
axis(side=2, at=seq(0, 3000, by=1000), labels=c("0", "2", "4", "6"))
dev.copy(png, file= "plot2.png")
dev.off()
