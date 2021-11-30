# OTU Clustering
# From Grand Canyon and Verde River eDNA


# Clear workspace and close all graphics devices --------------------------

rm(list = ls())
graphics.off()

# set working directory to proper repo

library(JAMP)
setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")


# Cluster filtered sequences by OTU with a 0.01% threshold ---------------------------------------

start_time <- Sys.time() # start timer to see how long the following for loop will take

# Take files from F_U_max_ee, which were filtered at an EE of 1
Max_ee_files <- list.files("F_U_max_ee/_data", full.names=T)
Max_ee_subset <- Max_ee_files[1:10]

Cluster_otus(files= Max_ee_files,
             filter=0.01)


end_time <- Sys.time() # end timer once for loop is completed

end_time - start_time


# Create a new OTU heatmap with better colors -----------------------------

OTU_heatmap(file = "J_Cluster_otus/5_OTU_table_0.01.csv",
            out = "GC_VR_OTU_Heatmap_0.01.pdf",
            abundance = TRUE,
            col = c("blue3", "white"))
