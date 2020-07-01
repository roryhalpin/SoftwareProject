library(tidyverse)

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")
read.csv("RawCarReg.csv") -> rawCarReg

# Rename corrupted LOCATION column
rawCarReg <- rawCarReg %>% 
  rename(
    LOCATION = ï..LOCATION
  )

# Display 
rawCarReg

# Drop columns we're not going to use both by name
rawCarReg <- select(rawCarReg, -c(SUBJECT,INDICATOR,MEASURE, Flag.Codes))

# Creating dataframe with just monthly frequency data
rawMonthlyData <- subset(rawCarReg, FREQUENCY == 'M') 

# Creating several Monthly and anual dataframes for different countries for initial testing
IRLCarRegM <- subset(rawCarReg, LOCATION =='IRL' & FREQUENCY =='M', select = c(LOCATION, FREQUENCY, TIME, Value))
CANCarRegM <- subset(rawCarReg, LOCATION =='CAN' & FREQUENCY =='M', select = c(LOCATION, FREQUENCY, TIME, Value))

# Display out new dataframes
IRLCarRegM

# Split the rawcar dataframe by each individual locaiton
# split(rawCarReg, rawCarReg$LOCATION)
rawMonthlyData
rawMonthlyData <- spread(rawMonthlyData, key = "LOCATION" ,value = "Value")
rawMonthlyData

# Making subset of rawmonthlydata with several countries that have NA values
rawMonthlyRemoveNAS <- subset(rawMonthlyData, select=c(FREQUENCY, TIME, BEL, CHE, DEU, DNK, FIN, ITA))
rawMonthlyRemoveNAS <- na.omit(rawMonthlyRemoveNAS)

# Write dataframes to a csv files
write.csv(IRLCarRegM, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/IRLCarRegM.csv", row.names = TRUE)
write.csv(CANCarRegM, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/CANCarRegM.csv", row.names = TRUE)
write.csv(rawMonthlyData, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/GlobalCarRegM.csv", row.names = TRUE)
