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
with(data, {
  plot(Sub_metering_1~Datetime, type="l",ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
