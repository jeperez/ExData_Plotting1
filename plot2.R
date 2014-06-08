##
##
##


library(data.table)
myColClasses = rep("characters", 9)
dt <- fread("household_power_consumption.txt",
            sep=";",
            na.strings="?",
            colClasses=myColClasses, ## just read the file, I'll coerce later
            verbose=FALSE)
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
dt <- dt[dt$Date==as.Date("2007-02-01")|dt$Date==as.Date("2007-02-02"),]

## Create a timestamp from the Date and Time columns
dateStr <- paste(dt$Date, dt$Time)
datetime <- strptime(dateStr, format="%Y-%m-%d %H:%M:%S")

## Plot a timeseries of Global Active Power and save it to a file
gap <- as.numeric(dt$Global_active_power)
png(filename="plot2.png", width=480, height=480, bg="transparent")
plot(datetime, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
