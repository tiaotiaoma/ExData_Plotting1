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
subpower$Sub_metering_1 <- as.numeric(subpower$Sub_metering_1)
subpower$Sub_metering_2 <- as.numeric(subpower$Sub_metering_2)
subpower$Sub_metering_3 <- as.numeric(subpower$Sub_metering_3)


with(subpower, {plot(DateTime, Sub_metering_1,type="l", xlab = "", ylab = "Engery sub metering")
        lines(DateTime, Sub_metering_2, col = "Red")
        lines(DateTime, Sub_metering_3, col = "Blue")})
legend("topright", lty= 1, lwd = 2, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width =480, height =480)
dev.off()
