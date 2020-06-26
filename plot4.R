library(lubridate)

power <- read.table("./household_power_consumption.txt",  
                    header = TRUE, 
                    sep = ";", 
                    na.strings = "?", 
                    colClasses = c(rep("character", 2), rep("numeric",7)))
##The fourth plot contains 4 subplots
# plot 2
# similar to plot 2 for "Voltage" with an xlab = datetime
# plot 3
# similar to plot 2 for "Global_reactive_power" with  xlab = datetime

#reclass power$Date
datetimes <- dmy_hms(paste(power$Date, power$Time))

#subset only the data we need. 
correct_dates <- which(date(datetimes) == dmy("01/02/2007") | date(datetimes) == dmy("02/02/2007"))
datetimes <- datetimes[correct_dates]
#open png graphics device
png(file = "plot4.png")

#set subplot shape
par(mfrow = c(2,2))

#first subplot
gap <- power[correct_dates, "Global_active_power"]
plot(datetimes, gap,
     ylab = "Global Active Power (kilowatts)",
     xlab = NA,
     type = "l",
     lwd = 2
)

#second subplot
volt <- power[correct_dates, "Voltage"]
plot(datetimes, volt,
     ylab = "Voltage",
     xlab = "datetime",
     type = "l"
)


#third subplot
submeters <- power[correct_dates, 7:9]
#Sub_metering 1
plot(datetimes, submeters[,1],
     ylab = "Energy sub metering",
     xlab = NA,
     type = "l",
     lwd = 1
)

#Sub_metering 2
lines(datetimes, submeters[,2],
      col = "red",
)

#Sub_metering 3
lines(datetimes, submeters[,3],
      col = "blue",
)

#legend
legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"),
       legend = names(submeters)
)

#fourth subplot
grp <- power[correct_dates, "Global_reactive_power"]
plot(datetimes, grp,
     ylab = "Global_reactive_power",
     xlab = "datetime",
     type = "l"
)
# This didn't work. The legend is all fussy
# dev.copy(png, file = "plot3.png")
dev.off()