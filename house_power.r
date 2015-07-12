#Project 1

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

#Plot 1 - Histogram
png("plot1.png",height = 480, width = 480)
hist(sset[,3],xlab = "Global Active Power (kilowatts)",ylab = "Frequency",
     col = "red",main = "Global Active Power")
dev.off()




