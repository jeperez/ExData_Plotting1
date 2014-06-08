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

## Plot a timeseries of different submetering readings and save it to a file
sm1 <- as.numeric(dt$Sub_metering_1)
sm2 <- as.numeric(dt$Sub_metering_2)
sm3 <- as.numeric(dt$Sub_metering_3)
png(filename="plot3.png", width=480, height=480, bg="transparent")
plot(datetime,   sm1, type="l", col="black", xlab="", ylab="Energy sub metering")
points(datetime, sm2, type="l", col="red")
points(datetime, sm3, type="l", col="blue")
legend("topright",
       lwd=c(1, 1, 1),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       border=c(1,4,1,1))
dev.off()
