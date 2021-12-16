## DADA2 ESV Clustering
# Created 12/16/21

library(dada2)

rm(list = ls())
graphics.off()


# Load fastq files and sort into F and R files ----------------------------

#Set working directory
wd <- "/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021/DADA2_Workflow"
setwd(wd)

#Create path to fastq files
path <- "../demulti_fastq/_data" 
list.files(path)

# Forward and reverse fastq filenames have format: SAMPLENAME_R1_001.fastq and SAMPLENAME_R2_001.fastq
fnFs <- sort(list.files(path, pattern="_R1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="_R2.fastq", full.names = TRUE))



