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
### convert the variable to numeric
subconsumption$Global_active_power <- as.numeric(subconsumption$Global_active_power)
####################################################################################

### set the limit for the Time axis
timestart <- as.POSIXct(strftime("2007-02-01 00:00:00"))
timeend <- as.POSIXct(strftime("2007-02-03 00:00:00"))
### Plot without naming the x-axis
with(subconsumption, plot(Time, Global_active_power, 
                          xlim = c(timestart,timeend), xaxt="n", 
                          type="l", xlab="", ylab = "Global Active Power (kilowatts)"))
### set the name of x-axis to be the short form of weekday
axis.POSIXct(1, at= seq(timestart, timeend, by="day"), format="%a")

dev.copy(png, "plot2.png")
dev.off()

