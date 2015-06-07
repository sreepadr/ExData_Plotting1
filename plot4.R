###############################################################################
## SCRIPT plot4.R
##  - Part 4 of a set of 4 scripts to make plots on a given dataset.
##  - PLOT: Multiple plots
##  - OUTPUT: plot4.png
##  - USAGE: source("plot4.R")
##  - ASSUMES: Working Directory contains "household_power_consumption.txt"
##  - Loads and prepares the dataset if it is not already available in the 
##    Global Environment.
##  - Plots the four vairations - Global Active Power against Date-Time, Sub  
##    Metering values against Date-Time, Voltage against Date-Time and Global 
##    Reactive power against Date-Time - all in the same figure
##    for two days - Thu, 2007-02-01 and Fri, 2007-02-02
###############################################################################

## PREPARE:

if(!exists("hpc.sub")) {
    # Load the dataset if it is not available in the global environment
    hpc <- read.table("household_power_consumption.txt", 
                      header=TRUE,
                      sep=";", 
                      colClasses="character")
    
    # Get the subset of our interest
    hpc.sub <- subset(hpc,as.Date(hpc$Date,"%d/%m/%Y")>=as.Date("2007-02-01") 
                      & as.Date(hpc$Date,"%d/%m/%Y")<=as.Date("2007-02-02"))
    
    # Remove the original dataset to free up memory
    rm("hpc")
    
    # Enrich the time column by adding date information also to it
    hpc.sub$Time <- paste(hpc.sub$Date,hpc.sub$Time)
    
    # Assign the correct datatypes (classes) to all columns
    hpc.sub$Date <- as.Date(hpc.sub$Date,"%d/%m/%Y")
    hpc.sub$Time <- strptime(hpc.sub$Time,"%d/%m/%Y %H:%M:%S")
    hpc.sub$Global_active_power <- as.numeric(hpc.sub$Global_active_power)
    hpc.sub$Global_reactive_power <- as.numeric(hpc.sub$Global_reactive_power)
    hpc.sub$Voltage <- as.numeric(hpc.sub$Voltage)
    hpc.sub$Global_intensity <- as.numeric(hpc.sub$Global_intensity)
    hpc.sub$Sub_metering_1 <- as.numeric(hpc.sub$Sub_metering_1)
    hpc.sub$Sub_metering_2 <- as.numeric(hpc.sub$Sub_metering_2)
    hpc.sub$Sub_metering_3 <- as.numeric(hpc.sub$Sub_metering_3)
}

## PLOT:

# Define the output file
png(file="plot4.png", width=480, height=480)

# Define the format: four plots in the same figure, in 2 rows and 2 columns
par(mfcol = c(2,2))

# Plots the four vairations - Global Active Power against Date-Time, Sub  
# Metering values against Date-Time, Voltage against Date-Time and Global 
# Reactive power against Date-Time
# for two days - Thu, 2007-02-01 and Fri, 2007-02-02

with (hpc.sub, {
    plot(x=hpc.sub$Time, 
         y=hpc.sub$Global_active_power, 
         type= "l", 
         ylab="Global Active Power", 
         xlab="")
   
    plot(x=hpc.sub$Time, 
         y=hpc.sub$Sub_metering_1, 
         type= "l", 
         ylab="Energy sub metering", 
         xlab="")
    points(x=hpc.sub$Time, 
           y=hpc.sub$Sub_metering_2, 
           type= "l", 
           ylab="Energy sub metering", 
           xlab="",
           col ="red")
    points(x=hpc.sub$Time, 
           y=hpc.sub$Sub_metering_3, 
           type= "l", 
           ylab="Energy sub metering", 
           xlab="",
           col ="blue")
    legend("topright", 
           col = c("black", "blue", "red"),
           lwd="1",
           legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
    
    plot(x=hpc.sub$Time, 
         y=hpc.sub$Voltage, 
         type= "l", 
         ylab="Voltage", 
         xlab="")    
    
    plot(x=hpc.sub$Time, 
         y=hpc.sub$Global_reactive_power, 
         type= "l", 
         ylab="Global_reactive_power", 
         xlab="")
})
dev.off()

