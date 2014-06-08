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

## Create four plots and save them to a file
gas <- as.numeric(dt$Global_active_power)
vol <- as.numeric(dt$Voltage)
sm1 <- as.numeric(dt$Sub_metering_1)
sm2 <- as.numeric(dt$Sub_metering_2)
sm3 <- as.numeric(dt$Sub_metering_3)
grp <- as.numeric(dt$Global_reactive_power)
png(filename="plot4.png", width=502, height=502, bg="transparent")
par(mfrow=c(2, 2))
    plot(datetime,   gas, type="l", xlab="", ylab="Global Active Power")
    plot(datetime,   vol, type="l", ylab="Voltage")
    plot(datetime,   sm1, type="l", col="black", xlab="", ylab="Energy sub metering")
    points(datetime, sm2, type="l", col="Red")
    points(datetime, sm3, type="l", col="blue")
    plot(datetime,   grp, type="l", ylab="Global_reactive_power")
dev.off()
