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


with(subpower, plot(DateTime, Global_active_power,type="l", xlab = "", 
                    ylab = "Global Acitve Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width =480, height =480)
dev.off()
