# Cluster sequences by OTUs for GC samples and VR samples independently
# Created 11/22/21


# Load JAMP and set working directory -------------------------------------

rm(list = ls())
graphics.off()

library(JAMP)

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")



# Cluster OTUs with Grand Canyon Samples ------------------------------------------------------------

Max_ee_GC <- list.files("Max_ee_GC/_data", full.names=T)

Cluster_otus(files= Max_ee_GC,
             filter=0.01)

OTU_heatmap(file = "Cluster_otus_GC/5_OTU_table_0.01.csv",
            out = "Grand_Canyon_OTU_Heatmap_0.01.pdf",
            abundance = TRUE,
            col = c("blue3", "white"))



# Cluseter OTUs with Verde River Samples ----------------------------------

Max_ee_VR <- list.files("Max_ee_VR/_data", full.names=T)

Cluster_otus(files= Max_ee_VR,
             filter=0.01)

OTU_heatmap(file = "Cluster_otus_VR/5_OTU_table_0.01.csv",
            out = "Verde_River_OTU_Heatmap_0.01.pdf",
            abundance = TRUE,
            col = c("blue3", "white"))


# Map2Ref for Verde River sites -----------------------------------------------------------------

Map2ref(files = Max_ee_VR, refDB = "J_Cluster_otus/3_Raw_OTU.fasta")



# Map2ref for Grand Canyon Sites ------------------------------------------

Map2ref(files = Max_ee_GC, refDB = "J_Cluster_otus/3_Raw_OTU.fasta")


OTU_heatmap(file = "Map2ref_GC/3_Raw_hit_table.csv",
            out = "Grand Canyon_OTU_Heatmap_0.01.pdf",
            abundance = TRUE,
            col = c("blue3", "white"))

Bold_web_hack(file="BOLDigger_output/BOLDResults_5_OTU_sub_0.01_JAMP_hit.txt")
