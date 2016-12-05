#Read in data

my_power_data<-read.csv("household_power_consumption.txt", sep=";")

# Create date string
my_power_dates<-paste(as(my_power_data$Date, "character"), as(my_power_data$Time, "character"))

# Put date string in Date format
POS_dates<-strptime(my_power_dates, "%d/%m/%Y %T", tz="")

# Add Dates to data

power_data <- cbind(my_power_data, POS_dates)

# Get start and end dates

start_date <-strptime("31/01/2007 23:59:59","%d/%m/%Y %T", tz="")
end_date <- strptime("02/02/2007 23:59:59","%d/%m/%Y %T", tz="")

# Subset the data 
two_days <- subset(power_data, power_data$POS_dates > start_date & power_data$POS_dates<end_date)

#Set legend details 

metering=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
colours=c("black", "red", "blue")

# Plot the graph 

plot(two_days$POS_dates, as.numeric(two_days$Sub_metering_1), type="l", col=colours[1], xlab="Time", ylab="Energy sub metering")
lines(two_days$POS_dates, as.numeric(two_days$Sub_metering_2),col=colours[2])
lines(two_days$POS_dates, as.numeric(two_days$Sub_metering_3),col=colours[3])
legend(x='topright',legend=metering,col=colours,lty="solid")
dev.copy(png, file="newplot3.png", width=480, height=480, units="px")
dev.off()