plot4 <- function(){
	hpc <- read_hpc(66637, 69517)

	png("plot4.png")	
	old.mfrow = par("mfrow")
	par(mfrow = c(2,2))

	plot(hpc$Global_active_power ~ hpc$DateTime, type = "l", ylab = "Global Active Power", xlab = "")  #Plot A

	plot(hpc$Voltage ~ hpc$DateTime, type = "l", ylab = "Voltage", xlab = "datetime") # Plot B

	plot(hpc$Sub_metering_1 ~ hpc$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")  #Plot C
	lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
	lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
	legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,lwd = 1, bty = "n")

	plot(hpc$Global_reactive_power ~ hpc$DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")  # Plot D
	
	par(mfrow = old.mfrow)
	dev.off()

}

read_hpc <- function(start, end){
	hpc <- read.table("household_power_consumption.txt",skip = start, nrows = end-start, sep = ";")
	hpc.names <- read.table("household_power_consumption.txt",nrows = 1, sep = ";")
	hn <- rep("NA",9)
	for(i in 1:length(hpc.names)){hn[i] <- as.character(hpc.names[[i]])}
	names(hpc) <- hn

	dtt <- paste(hpc[,"Date"],hpc[,"Time"], sep = " ")
	hpc <- cbind(strptime(dtt, format = "%d/%m/%Y %H:%M:%S"), hpc[,3:9])
	names(hpc)[1] <- "DateTime"
	hpc
}