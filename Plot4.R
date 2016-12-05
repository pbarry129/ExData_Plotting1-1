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

par(mfrow=c(2,2), mar=c(4,4,1,1))

with(two_days, {
 plot(POS_dates,as.numeric(Global_active_power),type="l", xlab="Time", ylab="Global Active Power") })
with(two_days, {
 plot(POS_dates,as.numeric(Voltage),type="l", xlab="datetime", ylab="Voltage")})
with(two_days, {
 plot(POS_dates, as.numeric(Sub_metering_1), type="l", col=colours[1], xlab="Time", ylab="Energy sub metering")
lines(POS_dates, as.numeric(Sub_metering_2),col=colours[2])
lines(POS_dates, as.numeric(Sub_metering_3),col=colours[3])
legend(x="topright",legend=metering,col=colours,lty="solid", text.width=strwidth("ThuFriSat")) })
with(two_days, {
plot(POS_dates, as.numeric(Global_reactive_power), type="l", xlab="datetime",   ylab="Global_reactive_power")})
dev.copy(png, file="plot4.png", width=480, height=480, units="px")
dev.off()


