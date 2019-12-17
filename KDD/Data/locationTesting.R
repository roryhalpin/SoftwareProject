library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(Amelia)
library(sf)
library(stringr)

print(getwd())

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")

loc <-read_sf("junctions.kml")

print(loc)

missmap(loc, main = "Missing values in junctions.kml")

loc_sample <- loc[sample(1:nrow(loc), 50,
                          replace=FALSE),]

print(loc_sample)

df = subset(loc_sample, select = -c(Name,Description) )

print(df)


df_split <- read.table(text=gsub('[()]', '', df$geometry), 
           sep=",", col.names=c('Latitute', 'Longitude'))
df %>% extract(geometry, c("Latitude", "Longitude"), "\\(([^,]+), ([^)]+)\\)")

print(df_split)
