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

forfiles_cut <- list.files(path = "primer_trim/ForFiles_Cutadapt/_data", full.names = TRUE)
revfiels_cut <- list.files(path = "primer_trim/RevFiles_Cutadapt/_data", full.names = TRUE)

#Inspect length distribution of trimmed sequences

length_dist_plot(filepath = "primer_trim/ForFiles_Cutadapt/_data", output = "primer_trim/ForFiles_Cutadapt/_stats/_length_distribution/") # forward length dist.

length_dist_plot(filepath = "primer_trim/RevFiles_Cutadapt/_data", output = "primer_trim/RevFiles_Cutadapt/_stats/_length_distribution/") # reverse length dist.

# Inspect Read Quality ----------------------------------------------------

plotQualityProfile(ForFiles_cut[50:55]) # visualize the quality profiles of F reads

plotQualityProfile(RevFiles_cut[1:2]) # visualize the quality profiles of R reads

# Both F and R reads are high quality (by the standards of the DADA2 manual). It is accepted that R reads are worse quality than F reads, and DADA2 accounts for this.


# Filter and Trim ---------------------------------------------------------

# create directories for forward and reverse filtered file outputs
dir.create("filter_and_trim")
forfiles_filt <- "filter_and_trim/forfiles_filt"
dir.create(forfiles_filt)
revfiles_filt <- "filter_and_trim/revfiles_filt"
dir.create(revfiles_filt)


# specify truncLen=142 -> only take reads of exactly the correct length
out_142 <- filterAndTrim(fwd = forfiles_cut, 
                     filt = forfiles_filt,
                     rev = revfiels_cut,
                     filt.rev = revfiles_filt,
                     truncLen=142,
                     maxN=0, #DADA2 required no Ns
                     maxEE=c(1,1), # sets max number of expected errors for forward and reverse (c(2,5) would mean 2 EE on for and 5 EE on rev)
                     truncQ=2, 
                     rm.phix=TRUE,
                     compress=TRUE, 
                     multithread=TRUE,
                     matchIDs=TRUE #enforces matching between id-line sequence identifiers
)

head(out_142)

out_142$percent_kept <- (out_142$reads.out/out$reads.in)*100 #calculate percent of reads kept for each sample
hist(out_142$percent_kept) #produce histogram of kept reads


# Learn the Error Rate ----------------------------------------------------

# learns a parametric error model from the data. every amplicon dataset is different, so DADA2 uses a machine learning algorithm to estimate the maximum possible error rate

for_err <- learnErrors(forfiles_filt, multithread=TRUE)
rev_err <- learnErrors(revfiles_filt, multithread=TRUE)

plotErrors(for_err, nominalQ=TRUE) #visualize estimated error rates



# Apply sample inference algorithm ----------------------------------------

# this removes the detected sequencing errors to reveal the members of the sequenced community

for_dada <- dada(forfiles_filt, err=for_err, multithread=TRUE)
rev_dada <- dada(revfiles_filt, err=rev_err, multithread=TRUE)



# Merge pair-end reads ----------------------------------------------------

mergers <- mergePairs(for_dada, forfiles_filt, rev_dada, revfiles_filt, verbose=TRUE)

#writeFastq(mergers$BA_1_S92_R1_cut.fastq, mode="w")

head(mergers[[1]])

saveRDS(mergers, file = "merge_pairs/DADA2_mergers.RDS") #create an RDS file containing mergers
load_mergers <- readRDS("merge_pairs/DADA2_mergers.RDS")


# Make ESV Table ----------------------------------------------------------

esv_table <- makeSequenceTable(mergers)

dim(esv_table) #get the numbber of ESVs identified (2nd number in the table dimensions)

table(nchar(getSequences(esv_table)))


# Remove chimeras ---------------------------------------------------------


esv_table.nochim <- removeBimeraDenovo(esv_table, method="consensus", multithread=TRUE, verbose=TRUE)

dim(esv_table.nochim)









