###  MiSeq_Demultiplexed_File_Processing  ###

# Created 11/9/21
# Updated 11/10/21

# This file contains a script to copy the original demultiplexed MiSeq file names from CQLS into a new folder, extract the information from the files, and rename the files to contain only the information needed by MergePE()

# Note: file renaming didn't work for Undetermined files, so those were renamed manually in Finder


# Clear workspace and close open graphics devices -------------------------
rm(list = ls())
graphics.off()
library(stringr)


# Set working directory? ---------------------------------------------------
setwd("/Users/jaredfreedman/Research/eDNA/GC_VR_miseq_demulti")

#unzip all files with .fastq.gz
# "*.fastq.gz" will unzip all files in the directory ending in that file format

system2("gunzip", "*.fastq.gz")


# Create a new folder and copy fastq files into that folder ---------------

dir.create("Renamed_fastq")
filenames <- list.files(pattern = "*.fastq")
file.copy(filenames, "Renamed_fastq")

setwd("/Users/jaredfreedman/Research/eDNA/GC_VR_miseq_demulti/Renamed_fastq")

# Read in SampleSheet CSV -------------------------------------------------

# Reads in SampleSheet and removes top part of sheet containing header information

SampleSheet <- read.csv("../Reports/SampleSheet.csv")
names(SampleSheet) <- SampleSheet[18,]
SampleSheet <- SampleSheet[19:112,]
SS1 <- SampleSheet
SS1$Sample_ID <- paste(SS1$Sample_ID, "_R1")
SS2 <- SampleSheet
SS2$Sample_ID <- paste(SS2$Sample_ID, "_R2")
Seq_Sheet <- rbind(SS1, SS2)
Seq_Sheet <- Seq_Sheet[order(Seq_Sheet$Sample_ID),]


# For loop that updates Sample Plate, Sample Well, and Sample Project in Seq_Sheet CSV baesd on MiSeq file name ------------------


filenames <- list.files(pattern = "*.fastq")
nfile <- length(filenames)
ifile <- 1


for(ifile in 1:nfile){

this_file <- filenames[ifile] # creates character for the current file name
this_file_split <- strsplit(this_file, split = "-")[[1]] # creates split character string of each component of file name from CQLS


lane <- this_file_split[1]   #creates character for lane number (Lane1 for all samples)
sample <- this_file_split[2]   #creates character for sample well number
site <- paste(this_file_split[7], this_file_split[8], sep = "_")   #creates character for site name (new fastq file name)
splitNA <- strsplit(site, split = "_NA")[[1]]   # split site string into site name and _NA (only for sites with NA for this_file_split[8])
sitename <- splitNA   # Create sitename using the name without NA
sitename_split <- strsplit(sitename, split = "_001")[[1]]   #these two lines create sitename without _001 at the end. merge_pe() needs files to end in R1 or R2
site_name <- paste(sitename_split[1], sitename_split[2], sep="")

Seq_Sheet$Sample_Plate[ifile] <- lane   #these three lines update the Seq_Sheet with new info 
Seq_Sheet$Sample_Well[ifile] <- sample
Seq_Sheet$Sample_Project[ifile] <- site_name

file.rename(this_file, Seq_Sheet$Sample_Project[ifile])
  
ifile <- ifile+1
}



# Write CSV of the Seq_Sheet data frame -----------------------------------

date <- Sys.Date()
Seq_Data_Sheet <- seqsheet 

write.csv(Seq_Sheet, "Seq_Data_Sheet.csv")



# Move renamed files into Git repo ----------------------------------------

renamed_files <-list.files(pattern = "*.fastq")

dir.create("Renamed_fastq")
dir.create("../../../git/edna_metabarcoding/GC_VR_MiSeq_2021/demulti_fastq")
git_repo <- "../../../git/edna_metabarcoding/GC_VR_MiSeq_2021/demulti_fastq"

file.copy(renamed_files, git_repo)

