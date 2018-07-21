####### --Ignore if already load the data-- ########################################
####################################################################################
### Read the data data.table format
library(data.table)
library(dplyr)
power_consumption <- fread("household_power_consumption.txt")
### subset to required dates
subconsumption <- power_consumption %>% 
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  mutate(Time = as.POSIXct(strptime(paste(Date, " ", Time), "%Y-%m-%d %H:%M:%S"))) %>%
  filter(Time >= strftime("2007-02-01 00:00:00"), Time <strftime("2007-02-03 00:00:00"))
### remove the original dataset
rm(power_consumption)
####################################################################################
### convert the variables to numeric
subconsumption <- mutate(subconsumption, Sub_metering_1 = as.numeric(Sub_metering_1), 
                  Sub_metering_2 = as.numeric(Sub_metering_2))
### set the limit for the Time axis
timestart <- as.POSIXct(strftime("2007-02-01 00:00:00"))
timeend <- as.POSIXct(strftime("2007-02-03 00:00:00"))
### Plot line for Sub metering 1
with(subconsumption, plot(Time, Sub_metering_1, 
                          xlim = c(timestart,timeend), xaxt="n", 
                          type="l", xlab="", ylab = "Energy sub metering"))
### Plot line for Sub metering 2 and 3
with(subconsumption, lines(Time,Sub_metering_2, col="red"))
with(subconsumption, lines(Time,Sub_metering_3, col="blue"))
### set the name of x-axis to be the short form of weekday
axis.POSIXct(1, at= seq(timestart, timeend, by="day"), format="%a")
### construct legend
legend("topright", legend= c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c("black","red", "blue"), lty = c(1,1,1))

dev.copy(png, "plot3.png")
dev.off()