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

## convert global active power to numeric
housed$Global_active_power <- as.numeric(as.character(housed$Global_active_power))

## set the png device
png(filename = "plot1.png", width = 480, height = 480)

## print the histogram
hist(housed$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", xlim = c(0, 6))

## close the device
dev.off()