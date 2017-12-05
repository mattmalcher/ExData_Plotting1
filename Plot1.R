library(dplyr)

# Location of data file
datalocation <- '../household_power_consumption.txt'

# Read to a Data Frame
hpcdata<-read.table(file=datalocation,sep = ";",header = TRUE, na.strings = "?")

# Change dates to dates rather than a factor, and filter to the range we will use.
hpcdata <- hpcdata %>% 
  mutate( Date=as.Date(Date,format="%d/%m/%Y") ) %>% 
  filter(between(Date, as.Date("2007-02-01"),as.Date("2007-02-02")))

hpcdata<-hpcdata %>% 
  mutate(Global_active_power = as.numeric(Global_active_power))


png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")


hist(hpcdata$Global_active_power,
     col='red',
     xlab='Global Active Power (kilowatts)',
     main = 'Global Active Power')

dev.off()
