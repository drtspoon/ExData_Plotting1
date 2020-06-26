library(lubridate)

power <- read.table("./household_power_consumption.txt",  
                    header = TRUE, 
                    sep = ";", 
                    na.strings = "?", 
                    colClasses = c(rep("character", 2), rep("numeric",7)))
##The third plot is a timeseries for "Energy sub metering". 
#The main title is NULL
#the colors are black, red, blue
#it has a legend

#reclass power$Date
datetimes <- dmy_hms(paste(power$Date, power$Time))

#subset only the data we need. 
correct_dates <- which(date(datetimes) == dmy("01/02/2007") | date(datetimes) == dmy("02/02/2007"))
datetimes <- datetimes[correct_dates]

submeters <- power[correct_dates, 7:9]

#open png graphics device
png(file = "plot3.png")
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

# This didn't work. The legend is all fussy
# dev.copy(png, file = "plot3.png")
dev.off()