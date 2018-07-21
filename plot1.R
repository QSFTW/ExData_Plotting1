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

### change the margin setting
par(mar=c(4,4,2,2))
### Plot with title, labels and colour
hist(subconsumption$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

### save the plot as png
dev.copy(png,"plot1.png")
dev.off()
