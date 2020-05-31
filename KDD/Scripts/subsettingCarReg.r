library(tidyverse)

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")
read.csv("RawCarReg.csv") -> rawCarReg

rawCarReg <- rawCarReg %>% 
  rename(
    LOCATION = ï..LOCATION
  )

rawCarReg

IRLCarRegA <- subset(rawCarReg, LOCATION =='IRL' & FREQUENCY =='A', select = c(LOCATION, FREQUENCY, TIME, Value))
IRLCarRegM <- subset(rawCarReg, LOCATION =='IRL' & FREQUENCY =='M', select = c(LOCATION, FREQUENCY, TIME, Value))

IRLCarRegA
IRLCarRegM
