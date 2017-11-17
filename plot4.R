# unzipping the folder and saving it in outDir
zipF<- "/Users/arushiagarwal/Documents/Coursera/John Hopkins course/Exploratory Data Analysis/week4.zip"
outDir<-"/Users/arushiagarwal/Documents/Coursera/John Hopkins course/Exploratory Data Analysis/unzip"
unzip(zipF,exdir=outDir)

# read data and subsetting
householddata <- read.table( "/Users/arushiagarwal/Documents/Coursera/John Hopkins course/Exploratory Data Analysis/unzip/household_power_consumption.txt", sep = ";",header = TRUE,na.strings="?",
                             stringsAsFactors=F, comment.char="", quote='\"')
summary(householddata)
str(householddata)
householddata$Date <- as.Date(as.character(householddata$Date),"%d/%m/%Y")

#subset
data <- subset(householddata, Date > "2007-01-31" & Date < "2007-02-03")
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#plotting the graph
par(mfrow=c(2,2), mar=c(3,3,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()