data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
datarange <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
datarange <- within(datarange, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S") })
datarange$timestamp <- strptime(datarange$timestamp, "%Y-%m-%d %H:%M:%S")

png(filename="plot4.png")

par(mfrow=c(2,2))

plot(x=datarange$timestamp, y=datarange$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(x=datarange$timestamp, y=datarange$Global_active_power)

plot(x=datarange$timestamp, y=datarange$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(x=datarange$timestamp, y=datarange$Voltage)

plot(x=c(datarange$timestamp, datarange$timestamp, datarange$timestamp), y=c(datarange$Sub_metering_1, datarange$Sub_metering_2, datarange$Sub_metering_3), type="n", xlab="", ylab="Energy sub metering")

lines(x=datarange$timestamp, y=datarange$Sub_metering_1)
lines(x=datarange$timestamp, y=datarange$Sub_metering_2, col="red")
lines(x=datarange$timestamp, y=datarange$Sub_metering_3, col="blue")

legend(x ="topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"))

plot(x=datarange$timestamp, y=datarange$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(x=datarange$timestamp, y=datarange$Global_reactive_power)

dev.off()