library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(Amelia)
library(sf)
library(stringr)

print(getwd())

setwd("C:/Users/sex-i/OneDrive/Documents/GitHub/Project/KDD/Data")

?register_google #sorting out API issues

ggmap::register_google(key = "AIzaSyA-Nae8E-50O3n-j4n1gOCGQJKYJWRWQVk")

# Reading in the KML file and pushing to dataframe
loc <-read_sf("junctions.kml")

print(loc)

# Checking for missing values
missmap(loc, main = "Missing values in junctions.kml")


# Pulling 50 entries for testing
loc_sample <- loc[sample(1:nrow(loc), 50,
                          replace=FALSE),]

print(loc_sample)

#Dumping Name and Description columns as they're empty
df = subset(loc_sample, select = -c(Name,Description) )

print(df)

#Splitting 
df_split <- read.table(text=gsub('[()]', '', df$geometry), 
           sep=",", col.names=c('x', 'y'))
df %>% extract(geometry, c("x", "y"), "\\(([^,]+), ([^)]+)\\)")

print(df_split)

# Trying to cleanse the "c" character out of the Latitude column with disapointing results
df_split_clean <- gsub("c", "", df_split$Latitude)

print(df_split_clean)

# Generating a google map plot of Dublin
p <- ggmap(get_googlemap(center = c(lon = -6.266155, lat = 53.350140),
                         zoom = 13, scale = 2,
                         maptype ='terrain',
                         color = 'color'))

p + geom_point(aes(x = Longitude, y = Latitude), data = df_split, size = 0.5) + 
  theme(legend.position="bottom")


