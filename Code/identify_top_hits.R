# Identifying top hits
# 12/1/2021

#

# Load packages and set working directory -------------------------------------

library(JAMP)
library(tidyverse)
library(ggplot2)

rm(list = ls())
graphics.off()

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/Taxonomy_Output/Boldigger_Grand_Canyon_output_30_11_21")

gc_bold_taxa <- read.csv("GC_OTU_Taxa_0.01.csv")

gc_bold_taxa <- rename(gc_bold_taxa,
                       bold_phylum = Phylum,
                       bold_class = Class,
                       bold_order = Order,
                       bold_family = Family,
                       bold_genus = Genus,
                       bold_species = Species)

gc_bold_taxa$Similarity <- as.numeric(gc_bold_taxa$Similarity)

gc_bold_taxa <- gc_bold_taxa[-c(199, 318, 496, 503, 699, 708),]

gc_bold_taxa[,"highest_level"] <- NA   # add a new empty column for highest taxonomic resolution based on similarity %

# OTUs to species level ---------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

for(i in 1:n){
  if(gc_bold_taxa$Similarity[i]>=98){
    gc_bold_taxa$highest_level[i] <- "species"
  }
  i <- i+1
}


# OTUs to genus level -----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

for(i in 1:n){
  if(gc_bold_taxa$Similarity[i]>=98){
    gc_bold_taxa$highest_level[i] <- "genus"
  }
  i <- i+1
}


# OTUs to family level ----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

for(i in 1:n){
  if(gc_bold_taxa$Similarity[i]>=98){
    gc_bold_taxa$highest_level[i] <- "family"
  }
  i <- i+1
}


# OTUs to order level -----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

for(i in 1:n){
  if(gc_bold_taxa$Similarity[i]>=98){
    gc_bold_taxa$highest_level[i] <- "order"
  }
  i <- i+1
}


# OTUs to class level -----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

for(i in 1:n){
  if(gc_bold_taxa$Similarity[i]>=98){
    gc_bold_taxa$highest_level[i] <- "class"
  }
  i <- i+1
}


