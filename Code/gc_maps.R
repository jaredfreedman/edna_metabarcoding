## Create map of sites based on GPS location
## 12/2/2021


# Load packages, set WD, and load CSV -------------------------------------

library(JAMP)
library(tidyverse)
library(ggplot2)
theme_set(theme_bw())
library(ggmap)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(maps)

rm(list = ls())
graphics.off()

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding")

sites <- read.csv("Sites_and_Samples/GC_VR_Sites_Barcodes.csv")
gc_sites <- subset(sites, sites$Project=="Grand Canyon")


# Try out a few sites -----------------------------------------------------


usa <- ne_countries(scale = "medium", returnclass = "sf", country = "united states of america", geounit = "united states of america")
states <- st_as_sf(map("state", plot = FALSE, fill = TRUE))

river <- ne_download(type = "rivers_lake_centerlines", category = "physical", returnclass = "sf", scale = 10)

sites <- data.frame(longitude = c(-112.0920, -112.2313), 
                     latitude = c(36.10030, 36.11537))

ggplot(data=usa)+
  geom_sf()+
  geom_sf(data=states)+
  geom_sf(data=river, col="blue")+
  coord_sf(xlim = c(-112.5, -111.5), ylim = c(36, 37), expand = FALSE)+
  geom_point(data = sites, aes(x = longitude, y = latitude))


c(lon = -112.0920, lat = 36.10030)
  


