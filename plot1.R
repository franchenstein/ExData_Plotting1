#Exploratory Data Analysis - Johns Hopkins Bloomberg School of Public Health - Coursera
#Project 1
#Plot 1
#----------------------------------------------------------------------------------------------------------------------
#This section is dedicated to load the data in the right format:
if (!file.exists("data")){
    dir.create("data")
}

if(!file.exists("./data/household_power_consumption.txt"))
{
    if (!file.exists("./data/exdata-data-household_power_consumption.zip")){
        furl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(furl, "./data/exdata-data-household_power_consumption.zip", method = "curl")
        dateDownloaded <- date()
    }
    unzip("./data/exdata-data-household_power_consumption.zip", exdir = "./data")
}

naChar <- "?"
startLine <- 66637 #Start reading at 1/2/2007 00:00:00
nLines <- 2880     #End reading at 2/2/2007 23:59:00
names <- colnames(read.table("./data/household_power_consumption.txt", header = TRUE, nrows = 1, sep = ";"))
readings <- read.table("./data/household_power_consumption.txt", header = FALSE, na.strings = naChar, sep = ";",
                   col.names = names, skip = startLine, nrows = nLines)
f <- "%d/%m/%Y,%H:%M:%S"
d <- paste(readings$Date, readings$Time, sep = ",")
t <- strptime(d, f)
readings$Full_date <- t
#----------------------------------------------------------------------------------------------------------------------

#Now the desired plot will actually be plotted:

png(file = "plot1.png")
with(readings, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()