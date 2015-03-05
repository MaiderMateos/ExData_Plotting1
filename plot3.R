
# Code for Plot 3

# Read the data selecting only the rows corresponding to 2007-2-1 and 2007-2-2

dat <- read.table("./household_power_consumption.txt", header=F, sep=";",
                  skip=grep("31/1/2007;23:59:00", readLines("./household_power_consumption.txt")),
                  nrows=2880)

# Set the variable names
colnames(dat) <- c("Date", "Time", "Global_active_power",
                   "Global_reactive_power", "Voltage", "Global_intensity",
                   "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Create the datetime variable
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat$datetime <- paste(dat$Date, dat$Time, sep=" ")
dat$datetime <- strptime(dat$datetime, format="%Y-%m-%d %H:%M:%S")

# Make the plot
# 480x480 pixels is the default
png("plot3.png")
plot(dat$datetime, dat$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(dat$datetime, dat$Sub_metering_2, type="l", col="red")
lines(dat$datetime, dat$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,col=c("black", "red", "blue"))
dev.off()