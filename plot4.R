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
data$Date <- dmy(data$Date)
df <- subset(data, Date >= as.Date("2007-02-01 00:00") 
             & Date < as.Date("2007-02-03"))

# Create a list of date-time variables. 
dttm <- strptime(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")

# Open a graphics device in a 4 by 4 grid. 
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot 1: linear plot of Global Active Power.
plot(dttm, df$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# Plot 2: linear plot of Voltage.
plot(dttm, df$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

# Plot 3: linear plot of Sub_metering 1, 2, and 3.
plot(dttm, df$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(dttm, df$Sub_metering_2, col = "red")
lines(dttm, df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4: linear plot of Global Reactive Power. 
plot(dttm, df$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global Reactive Power")

# Turn off graphics device.
dev.off()