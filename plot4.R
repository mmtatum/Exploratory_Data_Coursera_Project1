#Read in data file
#? is na in this dataset, na.strings='?'
#We don't want table values to be evaluated as factors, #stringsAsFactors=FALSE 

filename<-"household_power_consumption.txt"
data<-read.csv2(filename,header=TRUE,na.strings='?', stringsAsFactors=FALSE)

#Change date format from DD/MM/YYYY to YYYY-MM-DD
data$Date<-as.Date(data$Date,'%d/%m/%Y')

#Extract desired subset of data 
data<-subset(data, data$Date>= '2007-02-01' & data$Date<= '2007-02-02')

#Create a Time/Date data column 
data$DateTime<-strptime(paste(data$Date,data$Time),format='%Y-%m-%d %H:%M:%S')

#Create and Print histogram
png(file='plot4.png', width=480, height=480)
par(mfrow=c(2,2))
with(data,{
plot(DateTime,Global_active_power, type='l',ylab='Global Active Power',xlab='')
plot(DateTime,Voltage, type='l',ylab='Voltage',xlab='datetime')
plot(DateTime,Sub_metering_1, type='l',ylab='Energy sum metering',xlab='')
points(DateTime,Sub_metering_2, col='red',type='l')
points(DateTime,Sub_metering_3, col='blue',type='l')
legend("topright", lty=1, col = c("black","blue", "red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty='n')
plot(DateTime,Global_reactive_power, type='l',ylab='Global_reactive_power',xlab='datetime')
})
dev.off()
