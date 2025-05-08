# Download data if it has not been downloaded yet. Create a folder named "data"
# to store files, download .zip, unzip and delete .zip.
if(!file.exists("data")) {
    dir.create("data")
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl, destfile = "./data/file.zip")
    unzip("./data/file.zip", exdir = "./data/")
    file.remove("./data/file.zip")
}

# Read data into a data frame and subset relevant dates. For this project, we
# will include data from 2007-02-01 to 2007-02-02. Assign correct classes to 
# data frame.
library(readr)
library(lubridate)
library(dplyr)
data <- read_delim("./data/household_power_consumption.txt", 
                   delim = ";", 
                   na = c("", "?"))
data$Date <- dmy(data$Date)
data$Time <- hms::as_hms(data$Time)
data <- data %>% 
    filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create a data-time variable.
data$dttm <- as.POSIXct(strptime(paste(data$Date, data$Time),
                                format = "%Y-%m-%d %H:%M:%S"))

# Create a linear plot of Global Active Power ~ Data-Time and save into a 
# .png with the png graphics device. Close device. 
png("plot2.png", width = 480, height = 480)
plot(data$dttm, data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()