library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(Amelia)

print(getwd())

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")

hour_trips <- read.csv("trips-1-hour.csv")
print(hour_trips)

print(is.data.frame(hour_trips))
print(ncol(hour_trips))
print(nrow(hour_trips))

missmap(hour_trips, main = "Missing values in trips-1-hour.csv")