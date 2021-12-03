# Identifying top hits
# 12/1/2021

#

# Load packages and set working directory -------------------------------------

library(JAMP)
library(tidyverse)
library(ggplot2)

rm(list = ls())
graphics.off()

setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/Taxonomy_Output")

gc_bold_taxa <- read.csv("Boldigger_Grand_Canyon_output_30_11_21/GC_OTU_Taxa_0.01.csv")

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

high <- 100
low <- 98.00
between <- between(gc_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    gc_bold_taxa$highest_level[i] <- "species"
  }
  i <- i+1
}


# OTUs to genus level -----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

high <- 97.99
low <- 95.00
between <- between(gc_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
       gc_bold_taxa$highest_level[i] <- "genus"
  }
  i <- i+1
}


# OTUs to family level ----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

high <- 94.99
low <- 90.00
between <- between(gc_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    gc_bold_taxa$highest_level[i] <- "family"
  }
  i <- i+1
}

# OTUs to order level -----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

high <- 89.99
low <- 85.00
between <- between(gc_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    gc_bold_taxa$highest_level[i] <- "order"
  }
  i <- i+1
}

# OTUs to class level -----------------------------------------------------
i <- 1
n <- length(gc_bold_taxa$sort)

high <- 84.99
low <- 0
between <- between(gc_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    gc_bold_taxa$highest_level[i] <- "class"
  }
  i <- i+1
}



# make chart of hightest taxonomic identification -------------------------

high_id <- table(gc_bold_taxa$highest_level)

pie(high_id)

######################################################################################################################################################################
######################################################################################################################################################################


vr_bold_taxa <- read.csv("Boldigger_Verde_River_output_29_11_21/VR_OTU_Taxa_0.01.csv")

vr_bold_taxa <- rename(vr_bold_taxa,
                       bold_phylum = Phylum,
                       bold_class = Class,
                       bold_order = Order,
                       bold_family = Family,
                       bold_genus = Genus,
                       bold_species = Species)

vr_bold_taxa$Similarity <- as.numeric(vr_bold_taxa$Similarity)

vr_bold_taxa[,"highest_level"] <- NA   # add a new empty column for highest taxonomic resolution based on similarity %

# OTUs to species level ---------------------------------------------------
i <- 1
n <- length(vr_bold_taxa$sort)

high <- 100
low <- 98.00
between <- between(vr_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    vr_bold_taxa$highest_level[i] <- "species"
  }
  i <- i+1
}


# OTUs to genus level -----------------------------------------------------
i <- 1
n <- length(vr_bold_taxa$sort)

high <- 97.99
low <- 95.00
between <- between(vr_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    vr_bold_taxa$highest_level[i] <- "genus"
  }
  i <- i+1
}


# OTUs to family level ----------------------------------------------------
i <- 1
n <- length(vr_bold_taxa$sort)

high <- 94.99
low <- 90.00
between <- between(vr_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    vr_bold_taxa$highest_level[i] <- "family"
  }
  i <- i+1
}

# OTUs to order level -----------------------------------------------------
i <- 1
n <- length(vr_bold_taxa$sort)

high <- 89.99
low <- 85.00
between <- between(vr_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    vr_bold_taxa$highest_level[i] <- "order"
  }
  i <- i+1
}

# OTUs to class level -----------------------------------------------------
i <- 1
n <- length(vr_bold_taxa$sort)

high <- 84.99
low <- 0
between <- between(vr_bold_taxa$Similarity, low, high)

for(i in 1:n){
  if(between[i] == TRUE){
    vr_bold_taxa$highest_level[i] <- "class"
  }
  i <- i+1
}



# make chart of hightest taxonomic identification -------------------------

high_id <- table(vr_bold_taxa$highest_level)

pie(high_id)
