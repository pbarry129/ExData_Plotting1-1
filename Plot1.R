#Read in the power consumption data

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

hist(as.numeric(two_days$Global_active_power), main="Global Active Power", xlab = "Global Active Power (kilowatt)", col="red")
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off()







