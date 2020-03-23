library("dplyr")

# load the text file and use the dplyr format
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
data2 <- as_tibble(data)

# tidy the data
temp <- data2 %>% mutate(Date_Proper = as.Date(Date, "%d/%m/%Y"), DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")) %>% 
    filter(Date_Proper == as.Date("2007-02-01") | Date_Proper == as.Date("2007-02-02"))

# set output
png("plot4.png", width=480, height=480)

# draw the plots
par(mfrow=c(2,2))

# Plot
plot(temp$DateTime, temp$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(temp$DateTime,temp$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot
plot(temp$DateTime, temp$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(temp$DateTime, temp$Sub_metering_2, col="red")
lines(temp$DateTime, temp$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"),c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5) 

# Plot
plot(temp$DateTime, temp$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# reset device
dev.off()