
# Load JAMP and set working directory -------------------------------------

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

pie_labels <- paste0(unique_orders, " = ", round(100 * unique_orders/sum(unique_orders), 2), "%")

PieChart(x=unique_orders, main = "Orders of 90 most commom \n COI fragments in Verde River Samples",)





# Save this as a PDF ------------------------------------------------------

pdf(file="../Visual_Output/GC_orders.pdf")

PieChart(x=unique_orders, main = "Orders of 90 most commom \n COI fragments in Grand Canyon Samples")

dev.off()

