#Exploratory Data Analysis - Johns Hopkins Bloomberg School of Public Health - Coursera
#Project 1
#Plot 4
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

png(file = "plot4.png")
par(mfcol = c(2,2))
with(readings, {
    plot(Full_date, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    plot(Full_date, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
    lines(Full_date, Sub_metering_2, type = "l", col = "red")
    lines(Full_date, Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    plot(Full_date, Voltage, type = "l", xlab = "datetime")
    plot(Full_date, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()