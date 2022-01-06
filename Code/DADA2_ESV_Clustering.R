## DADA2 ESV Clustering
# Created 12/16/21

library(dada2)
library(JAMP)


rm(list = ls())
graphics.off()

wd <- "/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021/DADA2_Workflow"
setwd(wd)

# Sort fastq files into F and R -------------------------------------------

path <- "../demulti_fastq/_data" 
files <- list.files(path, full.names = T)

# Forward and reverse fastq filenames have format: SAMPLENAME_R1_001.fastq and SAMPLENAME_R2_001.fastq
ForFiles <- sort(list.files(path, pattern="_R1.fastq", full.names = TRUE))
RevFiles <- sort(list.files(path, pattern="_R2.fastq", full.names = TRUE))

# Extract sample names, assuming filenames have format: SAMPLENAME_XXX.fastq
# Only have to do it to fnFs, since it removes R1 or R2 designation
sample.names <- sapply(strsplit(basename(ForFiles), "_R1.fastq"), `[`, 1)
sample.names


# trim primer sequences ----------------------------

# import primer sequences (just COI primer sequence, not including universal tail)

primers <- read.csv("../../Sites_and_Samples/fwhF2_EPTDr2n_primer_sequences.csv")

#create character string with forward and reverse primers
fwhF2 <- primers$Sequence[primers$Name=="fwhF2"]
EPTDr2n <- primers$Sequence[primers$Name=="EPTDr2n"]

#Remove primers from Forward reads using CutAdapt from JAMP 

Cutadapt(files = ForFiles, 
         forward = fwhF2)

dirinfo <- file.info(list.dirs(recursive = FALSE)) #get directories in WD
recentdir <- rownames(dirinfo)[which.max(dirinfo$mtime)] #find most recent dir (the one created in cutadapt())
file.rename(recentdir, "ForFiles_Cutadapt") #rename file with a more descriptive name

#Remove primers from Reverse reads using CutAdapt from JAMP 

Cutadapt(files = RevFiles, 
         forward = EPTDr2n)

dirinfo <- file.info(list.dirs(recursive = FALSE)) #get directories in WD
recentdir <- rownames(dirinfo)[which.max(dirinfo$mtime)] #find most recent dir (the one created in cutadapt())
file.rename(recentdir, "RevFiles_Cutadapt") #rename file with a more descriptive name

#Create file path for forward and reverse trimmed Fastq files

ForFiles_cut <- list.files(path = "ForFiles_Cutadapt/_data", full.names = TRUE)
RevFiles_cut <- list.files(path = "RevFiles_Cutadapt/_data", full.names = TRUE)

# Inspect Read Quality ----------------------------------------------------

plotQualityProfile(ForFiles_cut[1:2]) # visualize the quality profiles of F reads

plotQualityProfile(RevFiles_cut[1:2]) # visualize the quality profiles of R reads

# Both F and R reads are high quality (by the standards of the DADA2 manual). It is accepted that R reads are worse quality than F reads, and DADA2 accounts for this.


# Filter and Trim ---------------------------------------------------------
dir.create("Filter_and_Trim")
dir.create("Filter_and_Trim/ForFiles_filt")
dir.create("Filter_and_Trim/RevFiles_filt")

out <- filterAndTrim(fwd = ForFiles_cut, 
                     filt = "Filter_and_Trim/ForFiles_filt",
                     rev = RevFiles_cut,
                     filt.rev = "Filter_and_Trim/RevFiles_filt",
                     truncLen=c(152, 132),
                     maxN=0, #DADA2 required no Ns
                     maxEE=c(2,2), # sets max number of expected errors for forward and reverse (c(2,5) would mean 2 EE on for and 5 EE on rev)
                     truncQ=2, 
                     rm.phix=TRUE,
                     compress=TRUE, 
                     multithread=TRUE)
head(out)


