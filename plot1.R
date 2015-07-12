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

# Zip file located here: http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip. 
# Download and extract household_power_consumption.txt file to your system.
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
selectdataset <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

selectdataset$Date <- as.Date(selectdataset[,1], format= "%d/%m/%Y")
refineddata <- selectdataset[selectdataset$Date == "2007-02-01",]
refineddata <- rbind(refineddata,selectdataset[selectdataset$Date == "2007-02-02",])
refineddata$Global_active_power <- as.numeric(refineddata$Global_active_power)

# Plot histogram

hist(refineddata$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)", col = "red",xaxt="n")
axis(side=1, at=seq(0, 3000, by=1000), labels=c("0", "2", "4", "6")) 
dev.copy(png, file= "plot1.png")
dev.off()
