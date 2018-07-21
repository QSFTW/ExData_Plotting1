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
                         Sub_metering_2 = as.numeric(Sub_metering_2), 
                         Voltage = as.numeric(Voltage), 
                         Global_active_power = as.numeric(Global_active_power),
                         Global_reactive_power = as.numeric(Global_reactive_power))
### set the limit for the Time axis
timestart <- as.POSIXct(strftime("2007-02-01 00:00:00"))
timeend <- as.POSIXct(strftime("2007-02-03 00:00:00"))

par(mfrow=c(2,2))

### Plot first graph, same as plot 2
with(subconsumption, plot(Time, Global_active_power, 
                          xlim = c(timestart,timeend), xaxt="n", 
                          type="l", xlab="", ylab = "Global Active Power"))
axis.POSIXct(1, at= seq(timestart, timeend, by="day"), format="%a")
### Plot second graph
with(subconsumption, plot(Time, Voltage, 
                          xlim = c(timestart,timeend), xaxt="n", 
                          type="l", xlab="datetime", ylab = "Voltage"))
axis.POSIXct(1, at= seq(timestart, timeend, by="day"), format="%a")
### Plot third graph, same as plot 3
with(subconsumption, plot(Time, Sub_metering_1, 
                          xlim = c(timestart,timeend), xaxt="n", 
                          type="l", xlab="", ylab = "Energy sub metering"))
with(subconsumption, lines(Time,Sub_metering_2, col="red"))
with(subconsumption, lines(Time,Sub_metering_3, col="blue"))
axis.POSIXct(1, at= seq(timestart, timeend, by="day"), format="%a")
legend("topright", legend= c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c("black","red", "blue"), lty = c(1,1,1))
### Plot fourth graph
with(subconsumption, plot(Time, Global_reactive_power, 
                          xlim = c(timestart,timeend), xaxt="n", 
                          type="l", xlab="datetime", ylab = "Global_rective_power"))
axis.POSIXct(1, at= seq(timestart, timeend, by="day"), format="%a")



