library("dplyr")


# load the text file and use the dplyr format
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
data2 <- as_tibble(data)

# tidy the data
temp <- data2 %>% mutate(Date_Proper = as.Date(Date, "%d/%m/%Y"), DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")) %>% 
    filter(Date_Proper == as.Date("2007-02-01") | Date_Proper == as.Date("2007-02-02"))

# set output
png("plot2.png", width=480, height=480)

# draw the plot
plot(x = temp$DateTime,y = temp$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

# reset device
dev.off()