# Trim primer sequences
# From Grand Canyon and Verde River eDNA

# Clear workspace and close all graphics devices --------------------------

rm(list = ls())
graphics.off()

# set working directory to proper repo

library(JAMP)
setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")

# import primer sequences (just COI primer sequence, not including universal tail)

primers <- read.csv("Sites_and_Samples/fwhF2_EPTDr2n_primer_sequences.csv")

#identify name of forward and reverse primer
#f.primer <- "fwhF2_"
#r.primer <- "EPTDr2n_"

#return TRUE or FALSE if each primer is Forward or Reverse
#is_f <- grepl(f.primer, primers$Name)
#is_r <- grepl(r.primer, primers$Name)

#create character string with forward and reverse primers
fwhF2 <- primers$Sequence[primers$Name=="fwhF2"]
EPTDr2n <- primers$Sequence[primers$Name=="EPTDr2n"]

#primer_sequences <- cbind(fwhF2,EPTDr2n)

# trim primers 
merged_files <- list.files("A_merge_PE/_data", full.names = TRUE)

Cutadapt(files = merged_files, 
         forward = fwhF2,
         reverse = EPTDr2n,
         bothsides=T)



#by using "bothsides=T", forward or reverse primers are detected on both ends. This is not nessesary for fusion primers.