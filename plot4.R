#Project 1

require(ggplot2)
require(xts)
require(lattice)

setwd("D:/Coursera/Exploratory Analysis/Project 1/house_power_data")

#Read data file
data = read.table("household_power_consumption.txt",nrows = 5,sep = ";",header = TRUE)
classes = sapply(data,class)
system.time(fulldata<-read.table("household_power_consumption.txt",
                                 sep = ";",header = TRUE,colClasses = classes,
                                 na.strings = "?"))

#Converting to POSIXlt format
dates = fulldata$Date
strp_dates = as.Date(strptime(dates,format = "%d/%m/%Y"),"%m%d%y")
class(strp_dates)
fulldata$Date = strp_dates

#Subsetting data according to the requirement
sset = subset(fulldata,Date == "2007-02-01" | Date == "2007-02-02")
days = weekdays(sset$Date,abbreviate = TRUE)
sset$Date = days

#Plot 4

png("plot4.png",height = 480, width = 480)
par(mfrow=c(2,2))

#Days vs Global Active Power
plot(sset[,3],type="l",xaxt="n",ylab = "Global Active Power (kilowatts)", xlab="")
axis(side = 1,at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))

#Days vs Voltage
plot(sset[,5],type="l",xaxt="n",ylab = "Voltage", xlab="datetime")
axis(side = 1,at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))

#Days vs Energy Sub Metering
plot(sset[,7],type="l",xaxt="n",xlab="",ylab = "Energy sub metering")
lines(sset[,8],col="red")
lines(sset[,9],col="blue")
axis(side = 1,at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
legend("topright",legend = names(sset[c(7:9)]),lty = 1,col = c("black","red","blue"))

#Days vs Global Reactive Power
plot(sset[,4],type="l",xaxt="n",ylab = "Global Reactive Power", xlab="datetime")
axis(side = 1,at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))

dev.off()




