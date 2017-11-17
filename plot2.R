

# unzipping the folder and saving it in outDir
zipF<- "/Users/arushiagarwal/Documents/Coursera/John Hopkins course/Exploratory Data Analysis/week4.zip"
outDir<-"/Users/arushiagarwal/Documents/Coursera/John Hopkins course/Exploratory Data Analysis/unzip"
unzip(zipF,exdir=outDir)

# read data and subsetting
householddata <- read.table( "/Users/arushiagarwal/Documents/Coursera/John Hopkins course/Exploratory Data Analysis/unzip/household_power_consumption.txt", sep = ";",header = TRUE,na.strings="?",
                             stringsAsFactors=F, comment.char="", quote='\"')
summary(householddata)
str(householddata)
bse <- householddata
householddata$Date <- as.Date(as.character(householddata$Date),"%d/%m/%Y")

data <- subset(householddata, Date > "2007-01-31" & Date < "2007-02-03")
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

with(data, {plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")})
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
