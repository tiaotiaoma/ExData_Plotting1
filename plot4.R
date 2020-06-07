library(data.table)
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                    na.strings ="?", stringsAsFactors = F)


# Subset power data from the datas 2007-02-01 and 2007-02-02
subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

# Convert the variable to the correct class  
subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")
DateTime <- paste(as.Date(subpower$Date), subpower$Time)
subpower$DateTime <- as.POSIXct(DateTime)
subpower$Global_active_power <- as.numeric(subpower$Global_active_power)
subpower$Global_reactive_power <- as.numeric(subpower$Global_reactive_power)
subpower$Voltage <- as.numeric(subpower$Voltage)
subpower$Sub_metering_1 <- as.numeric(subpower$Sub_metering_1)
subpower$Sub_metering_2 <- as.numeric(subpower$Sub_metering_2)
subpower$Sub_metering_3 <- as.numeric(subpower$Sub_metering_3)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subpower, {
        plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(DateTime, Voltage, type = "l", xlab="datetime", ylab="Voltage")
        plot(DateTime, Sub_metering_1,type="l", xlab = "", ylab = "Engery sub metering")
        lines(DateTime, Sub_metering_2, col = "Red")
        lines(DateTime, Sub_metering_3, col = "Blue")
        legend("topright", lty= 1, lwd = 2, bty = "n", col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power, type="l", xlab = "dateime", ylab="Global_reative_power")})


dev.copy(png, file = "plot4.png", width =480, height =480)
dev.off()