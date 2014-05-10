# read data from file
data <- read.csv("data\\household_power_consumption.txt",
                 sep=";",
                 na.strings="?",
                 colClasses=c("character","character","numeric","numeric",
                              "numeric","numeric","numeric","numeric","numeric"),
                 comment.char="")

# convert date and time fields to a DateTime field
data$DateTime = strptime(paste(data$Date,data$Time), 
                         "%d/%m/%Y %H:%M:%S")
data <- data[,-c(1,2)]

# filter for dates of 2007-02-01 and 2007-02-02
filteredData <- subset(data, 
                       DateTime >= as.POSIXct('2007-02-01') & 
                         DateTime < as.POSIXct('2007-02-03'))

# create a 480x480 png, 
# with transparent background
png(filename="plot4.png",
    width=480,
    height=480,
    bg="transparent")

# on a 2 x 2 grid
par(mfrow = c(2, 2))

# plot the data of the first graph
plot(filteredData$DateTime, 
     filteredData$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# plot the data of the second graph
plot(filteredData$DateTime, 
     filteredData$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

# plot the third graph - first set in black
plot(filteredData$DateTime, 
     filteredData$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering")

# plot the third graph - second set in red
lines(filteredData$DateTime, 
     filteredData$Sub_metering_2,
     col="red")

# plot the third graph - third set in blue
lines(filteredData$DateTime, 
      filteredData$Sub_metering_3,
      col="blue")

# add the legend to the third graph
legend("topright",
       lty=c(1,1,1),
       col=c("black","red","blue"),
       bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot the data of the fourth graph
plot(filteredData$DateTime, 
     filteredData$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

# close the device
dev.off()