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


sites$Sample <- sub("\\.", "_", sites$Sample)


# Create two new dataframes containing GC and VR sites --------------------

GC_sites <- subset(sites, sites$Project=="Grand Canyon")

VR_sites <- subset(sites, sites$Project=="Wilderness Canyons")



# Create new folder and fill with Grand Canyon max_ee .fasta files ---------

GC_dir <- "Max_ee_GC"
dir.create(GC_dir)

nfile <- length(GC_sites$Sample)
ifile <- 1

for(ifile in 1:nfile){
  GC_file <- list.files(path = "F_U_max_ee/_data", pattern = GC_sites$Sample[ifile], full.names = TRUE)
  file.copy(GC_file, GC_dir)
  ifile <- ifile+1
}

write.csv(GC_sites, "Sites_and_Samples/GC_Sites_Barcodes")

# Create new folder and fill with Verde River max_ee .fasta files ---------


VR_dir <- "Max_ee_VR"
dir.create(VR_dir)

nfile <- length(VR_sites$Sample)
ifile <- 1

for(ifile in 1:nfile){
  VR_file <- list.files(path = "F_U_max_ee/_data", pattern = VR_sites$Sample[ifile], full.names = TRUE)
  file.copy(VR_file, VR_dir)
  ifile <- ifile+1
}

write.csv(VR_sites, "Sites_and_Samples/VR_Sites_Barcodes")
