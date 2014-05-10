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
png(filename="plot1.png",
    width=480,
    height=480,
    bg="transparent")

#create the histogram in red
hist(filteredData$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# close the device
dev.off()