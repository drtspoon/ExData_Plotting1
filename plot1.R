library(lubridate)

power <- read.table("./household_power_consumption.txt",  
                    header = TRUE, 
                    sep = ";", 
                    na.strings = "?", 
                    colClasses = c(rep("character", 2), rep("numeric",7)))
##The first plot is a histogram that shows the frequency of "Global Active Power (kilowatts)". 
#The main title is "Global Active Power"
#the colors is red
#reclass power$Date
dates <- dmy(power$Date)
#subset only the data we need. 
correct_dates <- which(dates == dmy("01/02/2007") | dates == dmy("02/02/2007"))
#for future reference, this is 2880 rows after row 66637
gap <- power[correct_dates, "Global_active_power"]
hist(gap,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
)
dev.copy(png, file = "plot1.png")
dev.off()
     