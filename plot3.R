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
refineddata$Voltage = as.numeric(refineddata$Voltage)
refineddata$Global_reactive_power <-as.numeric(refineddata$Global_reactive_power)

# Plot Graph

par(yaxp=c(0,30,10))
with(refineddata, plot(newcol, Sub_metering_1, ylab="Energy sub metering",type="l",xlab="",yaxt="n")) #,ylim=c(0,30))), axis(side=2, at=seq(0, 30, by=10), labels=c("0", "10", "20", "30"))) #,lines(Sub_metering_2, type="l", col="blue"),lines(Sub_metering_3, type="l", col="red"))
axis(side=2, at=seq(0, 30, by=10), labels=c("0", "10", "20", "30"))
par(new=TRUE)
with(refineddata, plot(newcol, Sub_metering_2, type="l",xlab="",col="red",ylab="",ylim=c(0,300),axes = FALSE)) #, axis(side=2, at=seq(0, 30, by=10), labels=c("0", "10", "20", "30")))
par(new=TRUE)
with(refineddata, plot(newcol, Sub_metering_3,type="l",xlab="",col="blue",yaxt="n",ylab="",axes =FALSE,ylim=c(0,100)))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1),lwd=c(2,2,2), col = c("black","red","blue"),cex=0.55)
dev.copy(png, file= "plot3.png")
dev.off()
