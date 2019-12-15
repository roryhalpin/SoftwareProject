library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(Amelia)

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/SoftwareProject/KDD/Data")
print(getwd())

junctions <-read.csv("junctions.csv")
print(junctions)


#locations <- distinct(data, Location)
#locations
#locations_geo <- mutate_geocode(locations)

unique (unlist (lapply (junctions, function (x) which (is.na (x)))))

missmap(junctions, main = "Missing values in junctions.csv")

