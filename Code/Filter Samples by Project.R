# Create separate filtered datasets for Grand Canyon and Verde River sites
# Then cluster by OTUs and create heatmaps


# Load JAMP and set working directory -------------------------------------

rm(list = ls())
graphics.off()

library(JAMP)

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")


# Import sites and Barcodes CSV -------------------------------------------

sites <- read.csv("Sites_and_Samples/GC_VR_sites_Barcodes.csv", na.strings = c("NA", "", " "))   # Read in CSV with any blank cell being read as NA

sites <- sites[rowSums(is.na(sites)) != ncol(sites),]   # Remove any row that is completely NA



# Create two new dataframes containing GC and VR sites --------------------

is.GC <- sites$Project == "Grand Canyon"

#GC_sites <- sites

