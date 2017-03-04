## set working directory
setwd("C:/Users/Roger/DataScienceSpecialization/Course4-ExploratoryDataAnalysis/wk1")

## download zip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "householddata.zip")

## unzip and load data
household_data <- read.table(unz("householddata.zip", "household_power_consumption.txt"), sep = ";", header = T)

## sebset based on dates
housed <- subset(household_data, household_data$Date == "1/2/2007" | household_data$Date == "2/2/2007")

## remove original data
rm(household_data)

## convert date and time to datetime class
dt <- paste(housed$Date, housed$Time)
dt <- strptime(dt, "%d/%m/%Y %H:%M:%S")
names(dt) <- "dt"
housed <- cbind(dt, housed)
rm(dt)

## converting some parameters to numeric
housed$Global_active_power <- as.numeric(as.character(housed$Global_active_power))
housed$Sub_metering_1 <- as.numeric(as.character(housed$Sub_metering_1))
housed$Sub_metering_2 <- as.numeric(as.character(housed$Sub_metering_2))
housed$Sub_metering_3 <- as.numeric(as.character(housed$Sub_metering_3))
housed$Global_reactive_power <- as.numeric(as.character(housed$Global_reactive_power))
housed$Voltage <- as.numeric(as.character(housed$Voltage))

## set the png device
png(filename = "plot4.png", width = 480, height = 480)

## settings the environment for 4 graphs
par(mfrow = c(2 ,2))

## graph 1
plot(housed$dt, housed$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

## graph 2
plot(housed$dt, housed$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## graph 3
plot(x = housed$dt, y = housed$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(x = housed$dt, y = housed$Sub_metering_1, type = "l", col = "black")
lines(x = housed$dt, y = housed$Sub_metering_2, type = "l", col = "red")
lines(x = housed$dt, y = housed$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"))

## graph 4
plot(housed$dt, housed$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global reactive power")

## close the device
dev.off()