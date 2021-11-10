


# Clear workspace and close open graphics devices -------------------------
rm(list = ls())
graphics.off()


# Set working directory? ---------------------------------------------------
setwd("/Users/jaredfreedman/Research/eDNA/GC_VR_miseq_demulti")



# Read in SampleSheet CSV -------------------------------------------------

# Reads in SampleSheet and removes top part of sheet containing header information

SampleSheet <- read.csv("Reports/SampleSheet.csv")
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

Seq_Sheet$Sample_Plate[ifile] <- lane   #these three lines update the Seq_Sheet with new info 
Seq_Sheet$Sample_Well[ifile] <- sample
Seq_Sheet$Sample_Project[ifile] <- sitename

ifile <- ifile+1

#sitename <- strsplit(contains_sitename, split = "_")[[1]]

file.rename(this_file, sitename)
  
}



