## Taxonomy Analysis
# Created 1/8/22


rm(list = ls())
graphics.off()

library(JAMP)
library(dplyr)
library(ggplot2)
library(lessR)

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")

otu_taxa <- read.csv(file = "../Taxonomy_Output/Boldigger_Grand_Canyon_output_30_11_21/GC_OTU_Taxa_0.01.csv")

unique_orders <- table(otu_taxa$Order)

unique_orders_df <- as.data.frame(unique_orders)


# Turn read count into presence/absence data ------------------------------
otu_PA <- otu_taxa

otu_matrix <- as.matrix(otu_PA[3:76]) #create matrix of OTU read counts
otu_matrix[otu_matrix>0] <- 1 #assign value of 1 to any location with >0 reads
otu_df <- as.data.frame(otu_matrix) #convert matrix back to df
otu_PA <- otu_PA[-c(3:77)] #remove the read count data from otu_PA 

otu_PA <- cbind(otu_PA, otu_df) #combine presence/absence data with taxonomy data



# separate trib and mainstem samples --------------------------------------

if(names(otu_df)[col("CR*")]){
  
}


# Unique Spp, Genus, Orders -----------------------------------------------

species_num <- length(unique(otu_taxa$Species))
genus_num <-length(unique(otu_taxa$Genus[otu_taxa$Species==""]))
family_num <- length(unique(otu_taxa$Family[otu_taxa$Genus==""]))
order_num <- length(unique(otu_taxa$Order[otu_taxa$Family==""]))

species_num
genus_num
family_num
order_num

diptera_spp <- length(unique(otu_taxa$Species[otu_taxa$Order=="Diptera"]))
diptera_spp