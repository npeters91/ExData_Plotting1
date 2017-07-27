# coursera Specialization:      "Data Science" by Johns Hopkins University
# Course:                       4. Exploratory Data Analysis
# Assignment:                   Course Project 1

# Author:                       Niek Alexander Peters, MD
#                               PhD Candidate Surgical Oncology
#                               UMC Utrecht, The Netherlands

# Download file, unzip and load data
dataSet <- "dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(dataSet)) {
        download.file(fileUrl, dataSet, method = "auto")
        unzip(dataSet)
}

# Load dependencies
if (!("data.table" %in% rownames(installed.packages()))) {install.packages("data.table")}
suppressMessages(library(data.table))
if (!("sqldf" %in% rownames(installed.packages()))) {install.packages("sqldf")}
suppressMessages(library(sqldf))

# Read in data
hpc <- rbind(
        read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date == '1/2/2007' ", header = TRUE, sep = ";"),
        read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date == '2/2/2007' ", header = TRUE, sep = ";")
)

# Converse Date and Time string vectors to date and time objects
DateTime <- strptime(paste(hpc$Date, hpc$Time), format = '%d/%m/%Y %H:%M:%S')
hpc$DateTime <- DateTime

# Start PNG device
png(filename = "./plot3.png", width = 480, height = 480, bg = "transparent")

# Draw the plot (Sub_metering per time)
plot(hpc$DateTime, hpc$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(hpc$DateTime, hpc$Sub_metering_1, col = "black")
lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col=c("black", "red", "blue"), legend= c("Sub_metering 1", "Sub_metering 2", "Sub_metergin 3"))

# Stop the device
dev.off()