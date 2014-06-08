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

## Create a histogram using the base package and save it to a file
gap <- as.numeric(dt$Global_active_power)
png(filename="plot1.png", width=480, height=480, bg="transparent")
hist(x = gap,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"
     )
dev.off()
