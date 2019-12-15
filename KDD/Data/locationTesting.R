library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(Amelia)
library(sf)

print(getwd())

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")

loc <-read_sf("junctions.kml")

print(loc)

missmap(loc, main = "Missing values in junctions.kml")

