# Cluster sequences by OTUs for GC samples and VR samples independently
# Created 11/22/21


# Load JAMP and set working directory -------------------------------------

rm(list = ls())
graphics.off()

library(JAMP)

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")



# Cluster OTUs ------------------------------------------------------------

Max_ee_GC <- list.files("Max_ee_GC/_data", full.names=T)

Cluster_otus(files= Max_ee_GC,
             filter=0.01)
