# use of data.table structure, since it's faster than data.frame
library(data.table)

# Set the locale specifically, to show the day abbreviations in English
Sys.setlocale("LC_TIME", "C")

# read the data file
dat <- fread("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

# subset the data.table to keep only the dates 1-2 February 2007
dat <- dat[dat$Date=="1/2/2007" | dat$Date=="2/2/2007",]

# replace the Date and Time columns with a single DateTime column expressed
# as in the POSIXct format
dat[,DateTime := as.POSIXct(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"))]
dat[,Date := NULL]
dat[,Time := NULL]

# draw the graph of plot 2 and save it to a png file
png("plot2.png",height = 480,width = 480,units="px",bg = NA)
with(dat, plot(DateTime, Global_active_power,type="l",main = NA, xlab = NA,ylab = "Global Active Power (kilowatts)"))
dev.off()  
