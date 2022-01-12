# Read Stats
# Created 1/8/22
# Stats regarding read count to be included in SFS abstract

read_stats_total <- read.csv("/Users/jaredfreedman/Research/eDNA/GC_VR_miseq_demulti/Reports/Demultiplex_Stats_GC.csv")
read_stats <- read_stats_total[-c(11, 27, 42),] # remove read counts for samples with >4000 reads

sum_read <- sum(read_stats$X..Reads)

min_read <- min(read_stats$X..Reads)
max_read <- max(read_stats$X..Reads)

avg_read <- mean(read_stats$X..Reads)
sum_read
min_read
max_read
avg_read


# filtered stats ----------------------------------------------------------

# assess the number of reads that passed quality filtering (min/max of +/- 10bp and max EE of 1)

filt_total <- read.csv("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021/F_U_max_ee/_stats/F_max_ee_stats.csv")
filt <- filt_total[-c(5,6,47,48,63,64,69,70,79,80,85:95),] #remove VR samples

sum_filt <- sum(filt$Sequ_count_out)
sum_filt

