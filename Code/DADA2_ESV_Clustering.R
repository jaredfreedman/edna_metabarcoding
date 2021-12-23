## DADA2 ESV Clustering
# Created 12/16/21

library(dada2)
library(JAMP)


rm(list = ls())
graphics.off()


# Load fastq files and trim primer sequences ----------------------------

#Set working directory
wd <- "/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021/DADA2_Workflow"
setwd(wd)

#Create path to fastq files
path <- "../demulti_fastq/_data" 
list.files(path)




# Sort fastq files into F and R -------------------------------------------

# Forward and reverse fastq filenames have format: SAMPLENAME_R1_001.fastq and SAMPLENAME_R2_001.fastq
fnFs <- sort(list.files(path, pattern="_R1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_R2.fastq", full.names = TRUE))

# Extract sample names, assuming filenames have format: SAMPLENAME_XXX.fastq
# Only have to do it to fnFs, since it removes R1 or R2 designation
sample.names <- sapply(strsplit(basename(fnFs), "_R1.fastq"), `[`, 1)
sample.names


# Inspect Read Quality ----------------------------------------------------

plotQualityProfile(fnFs[1:2]) # visualize the quality profiles of F reads

plotQualityProfile(fnRs[1:2]) # visualize the quality profiles of R reads

# Both F and R reads are high quality (by the standards of the DADA2 manual). It is accepted that R reads are worse quality than F reads, and DADA2 accounts for this.


# Filter and Trim ---------------------------------------------------------


