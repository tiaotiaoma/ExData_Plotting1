# Read data into R 

library(data.table)
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                    na.strings ="?", stringsAsFactors = F)

# Subset power data from the datas 2007-02-01 and 2007-02-02
subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

# Convert the variable to the correct class  
subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")
subpower$Global_active_power <- as.numeric(subpower$Global_active_power)

# Create hist plot of Global Active Power
png(file = "plot1.png", width = 480, height = 480 )
hist(subpower$Global_active_power, main =" Global Active Power",
     xlab ="Gloabl Active Power(kilowatts)", ylab ="Frequency", col = "Red")
dev.off()
