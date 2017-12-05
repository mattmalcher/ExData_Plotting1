library(dplyr)

# Location of data file
datalocation <- '../household_power_consumption.txt'

# Read to a Data Frame
hpcdata<-read.table(file=datalocation,sep = ";",header = TRUE, na.strings = "?")

# Change dates to dates rather than a factor, and filter to the range we will use.
hpcdata <- hpcdata %>% 
  mutate( DateOnly=as.Date(Date,format="%d/%m/%Y") ) %>% 
  filter(between(DateOnly, as.Date("2007-02-01"),as.Date("2007-02-02")))

# Combine the Date and Time as strings then use strptime to convert them to posix times
hpcdata<-hpcdata %>% 
  mutate(DateTime = paste(as.character(Date), as.character(Time))) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime,format="%d/%m/%Y %H:%M:%S")))
  

#Change gap to a number  
hpcdata<-hpcdata %>%  
  mutate(Global_active_power = as.numeric(Global_active_power))


png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

# Set 2x2 grid
par(mfcol=c(2,2))

# Plot Global Active Power 
plot(hpcdata$DateTime, hpcdata$Global_active_power, type='l',
     col='black',
     ylab='Global Active Power',
     xlab='')

# Plot Sub Metering
plot(hpcdata$DateTime, hpcdata$Sub_metering_1, col='black', 
     type='l', ylab='Energy sub metering',xlab='')
lines(hpcdata$DateTime, hpcdata$Sub_metering_2, col='red')
lines(hpcdata$DateTime, hpcdata$Sub_metering_3, col='blue')
legend('topright', 
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c('black', 'red', 'blue'),
       lty=1,
       bty='n')

# Plot Voltage
plot(hpcdata$DateTime, hpcdata$Voltage, type='l',
     col='black',
     ylab='Voltage',
     xlab='datetime')

# Plot Global Reactive Power
plot(hpcdata$DateTime, hpcdata$Global_reactive_power, type='l',
     col='black',
     ylab='Global_reactive_power',
     xlab='datetime')

dev.off()
