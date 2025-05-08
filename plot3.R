# Download data if it has not been downloaded yet. Create a folder named "data"
# to store files, download .zip, unzip and delete .zip.
if(!file.exists("data")) {
    dir.create("data")
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl, destfile = "./data/file.zip")
    unzip("./data/file.zip", exdir = "./data/")
    file.remove("./data/file.zip")
}

# Load relevant packages = readr, lubridate and dplyr.
library(readr)
library(lubridate)
library(dplyr)

# Read data into a data frame and create a date-time variable. 
data <- read_delim("./data/household_power_consumption.txt", 
                   delim = ";", 
                   na = c("", "?"))
data$dttm <- dmy_hms(paste(data$Date, data$Time))
df <- subset(data, dttm >= as.Date("2007-02-01 00:00") 
             & dttm < as.Date("2007-02-03"))

# Create a linear plot for the three energy sub metering measurements along
# the two-day period we observe for this project.
png("plot3.png", width = 480, height = 480)
plot(df$dttm, df$Sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(df$dttm, df$Sub_metering_1, col = "black")
lines(df$dttm, df$Sub_metering_2, col = "red")
lines(df$dttm, df$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue"))
dev.off()