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
data <- data %>% 
    filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create a histogram of Global Active Power as a . png.
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()



