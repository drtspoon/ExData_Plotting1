library(lubridate)

power <- read.table("./household_power_consumption.txt",  
                    header = TRUE, 
                    sep = ";", 
                    na.strings = "?", 
                    colClasses = c(rep("character", 2), rep("numeric",7)))
##The second plot is a timeseries for "Global Active Power (kilowatts)". 
#The main title is NULL
#the colors is black
#reclass power$Date


datetimes <- dmy_hms(paste(power$Date, power$Time))
#subset only the data we need. 
correct_dates <- which(date(datetimes) == dmy("01/02/2007") | date(datetimes) == dmy("02/02/2007"))
datetimes <- datetimes[correct_dates]
gap <- power[correct_dates, "Global_active_power"]
plot(datetimes, gap,
     ylab = "Global Active Power (kilowatts)",
     xlab = NA,
     type = "l",
     lwd = 2
)
dev.copy(png, file = "plot1.png")
dev.off()