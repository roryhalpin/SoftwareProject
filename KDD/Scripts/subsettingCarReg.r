library(tidyverse)
library(naniar)

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")
read.csv("RawCarReg.csv") -> rawCarReg
read.csv("RawCarRegUpdated.csv") -> rawCarRegUpdated # Newer data downloaded 6th July 2020

# Rename corrupted LOCATION column
rawCarReg <- rawCarReg %>% 
  rename(
    LOCATION = ï..LOCATION
  )

rawCarRegUpdated <- rawCarRegUpdated %>% 
  rename(
    LOCATION = ï..LOCATION
  )

# Display 
rawCarReg
rawCarRegUpdated
head(rawCarReg)

# Drop columns we're not going to use by name
rawCarReg <- select(rawCarReg, -c(SUBJECT,INDICATOR,MEASURE, Flag.Codes))
rawCarRegUpdated <- select(rawCarRegUpdated, -c(SUBJECT,INDICATOR,MEASURE, Flag.Codes))

is.na(rawCarRegUpdated)
vis_miss(rawCarRegUpdated)+
theme_dark()

# Creating dataframe with just monthly frequency data
rawMonthlyData <- subset(rawCarReg, FREQUENCY == 'M')
rawMonthlyDataUpdated <- subset(rawCarRegUpdated, FREQUENCY == 'M')

# Creating several Monthly and anual dataframes for different countries for initial testing
IRLCarRegM <- subset(rawCarReg, LOCATION =='IRL' & FREQUENCY =='M', select = c(LOCATION, FREQUENCY, TIME, Value))
CANCarRegM <- subset(rawCarReg, LOCATION =='CAN' & FREQUENCY =='M', select = c(LOCATION, FREQUENCY, TIME, Value))

# Display out new dataframes
IRLCarRegM

# Split the rawcar dataframe by each individual locaiton
rawMonthlyData <- spread(rawMonthlyData, key = "LOCATION" ,value = "Value") # split(rawCarReg, rawCarReg$LOCATION)
rawMonthlyData

rawMonthlyDataUpdated <- spread(rawMonthlyDataUpdated, key = "LOCATION" ,value = "Value")
rawMonthlyDataUpdated
vis_miss(rawMonthlyDataUpdated)

# Making subset of rawmonthlydata with several countries that have NA values
rawMonthlyRemoveNAS <- subset(rawMonthlyData, select=c(FREQUENCY, TIME, BEL, CHE, DEU, DNK, FIN, ITA))
rawMonthlyRemoveNAS <- na.omit(rawMonthlyRemoveNAS)

# Creating a seperate file with the 28 27 EU member states
EU27Data <-subset(rawMonthlyDataUpdated, select=c(TIME, AUT, BEL, CZE, DEU, DNK, ESP, EST, EU27_2020, FRA, GBR, GRC, HUN, IRL, ITA, LTU, LUX, LVA, NLD, POL, PRT, SVK, SVN, SWE))
vis_miss(EU27Data)
gg_miss_fct(EU27Data, TIME)

# Removing first 97 rows
N <- 97

EU27Data <- tail(EU27Data, -N)

EU27Data <- EU27Data %>%
  rename(
    EU27 = EU27_2020
  )
EU27Data 
head(EU27Data)

EU27NAS <- na.omit(EU27Data)
EU27NAS

#replacing NAs with zero
EU27NASReplace <- EU27Data
EU27NASReplace[is.na(EU27NASReplace)] <- 0
EU27NASReplace

# Write dataframes to a csv files
write.csv(IRLCarRegM, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/IRLCarRegM.csv", row.names = TRUE)
write.csv(CANCarRegM, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/CANCarRegM.csv", row.names = TRUE)
write.csv(rawMonthlyData, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/GlobalCarRegM.csv", row.names = TRUE)
write.csv(rawMonthlyRemoveNAS, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/TestNasRemoved.csv", row.names = TRUE)
write.csv(EU27Data, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/EU27.csv", row.names = TRUE)
write.csv(EU27NAS, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/EU27NAS.csv", row.names = TRUE)
write.csv(EU27NASReplace, "C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data/EU27NASas0.csv", row.names = TRUE)
