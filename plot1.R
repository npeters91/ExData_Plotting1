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
png(filename = "./plot1.png", width = 480, height = 480, bg = "transparent")

# Draw the plot (histogram of Global Active Power)
hist(hpc$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

# Stop the device
dev.off()