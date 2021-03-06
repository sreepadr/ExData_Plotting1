###############################################################################
## SCRIPT plot2.R
##  - Part 2 of a set of 4 scripts to make plots on a given dataset.
##  - PLOT: Global Active Power against Date-Time
##  - OUTPUT: plot2.png
##  - USAGE: source("plot2.R")
##  - ASSUMES: Working Directory contains "household_power_consumption.txt"
##  - Loads and prepares the dataset if it is not already available in the 
##    Global Environment.
##  - Plots variation of Global Active Power against Date-Time
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
png(file="plot2.png", width=480, height=480)

# Plot variation of Global Active Power against Date-Time
# for two days - Thu, 2007-02-01 and Fri, 2007-02-02
plot(x=hpc.sub$Time, 
     y=hpc.sub$Global_active_power, 
     type= "l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")
dev.off()

