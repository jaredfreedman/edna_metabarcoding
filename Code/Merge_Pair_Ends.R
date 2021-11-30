# Merge Pair-Ended Reads
# From Grand Canyon and Verde River eDNA


# Clear workspace and close all graphics devices --------------------------

rm(list = ls())
graphics.off()

# set working directory to proper repo

library(JAMP)
setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")


# Merge pair-ended reads --------------------------------------------------


demulti_files <- list.files("demulti_fastq/_data", full.names = TRUE)


Merge_PE(files = demulti_files)
