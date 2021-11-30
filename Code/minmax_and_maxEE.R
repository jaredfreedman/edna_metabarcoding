# Minmax and Max EE filtering
# From Grand Canyon and Verde River eDNA


# Clear workspace and close all graphics devices --------------------------

rm(list = ls())
graphics.off()

# set working directory to proper repo

library(JAMP)
setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")


# Filter sequences to only include +/- 10bp of the expected fragme --------

Cutadapt_files <- list.files("D_Cutadapt/_data", full.names = TRUE)

Minmax(files = Cutadapt_files,
       min=(142-10),
       max=(142+10))


# Filter sequences by expected error (1.0) --------------------------------

Minmax_files <- list.files("E_Minmax/_data", full.names = TRUE)

Max_ee(files = Minmax_files,
       max_ee=1)
#Output in F_U_max_ee 
