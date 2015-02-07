data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
datarange <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
datarange <- within(datarange, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S") })
datarange$timestamp <- strptime(datarange$timestamp, "%Y-%m-%d %H:%M:%S")

png(filename="plot3.png")

plot(x=c(datarange$timestamp, datarange$timestamp, datarange$timestamp), y=c(datarange$Sub_metering_1, datarange$Sub_metering_2, datarange$Sub_metering_3), type="n", xlab="", ylab="Energy sub metering")

lines(x=datarange$timestamp, y=datarange$Sub_metering_1)
lines(x=datarange$timestamp, y=datarange$Sub_metering_2, col="red")
lines(x=datarange$timestamp, y=datarange$Sub_metering_3, col="blue")

legend(x ="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"))

dev.off()