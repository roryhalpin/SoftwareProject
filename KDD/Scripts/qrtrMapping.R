library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(Amelia)

print(getwd())

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")

qrtr_trips <- read.csv("trips-15-mins.csv")

print(is.data.frame(qrtr_trips))
print(ncol(qrtr_trips))
print(nrow(qrtr_trips))

missmap(qrtr_trips, main = "Missing values in trips-15-mins.csv")