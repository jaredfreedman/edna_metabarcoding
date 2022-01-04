# Create Length Distribution plots for trimmed sequences

# Clear workspace and close all graphics devices --------------------------

rm(list = ls())
graphics.off()

# set working directory to proper repo

library(JAMP)
setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")


# Create new directory for files -----------------------------------------

dir.create("_Length_distribution_cutadapt", 
           path = "DADA2_Workflow/ForFiles_Cutadapt/_Length_distribution_cutadapt")


# For loop that creates length dist plot for each file from C_cuta --------

length_dist_plot <- function(filepath = "", output = "", split = "_cut.fastq"){

  trimmed_files <- list.files(path = filepath, full.names = TRUE) # Create list of file names
  nfile <- length(trimmed_files)
  ifile <- 1
  
  for(ifile in 1:nfile){
    
    file <- trimmed_files[ifile]   #create character string containing the file path and name
    filename <- strsplit(trimmed_files[ifile], split="_cut.fastq")[[1]]   #create character string that contains file name without _PE_cut or .fastq extention
    filename <- strsplit(filename, split="/")[[1]][4]   #remove the file path from the filename (done by splitting string by /, and only taking the 3rd part)
    
    
    Length_distribution(sequFile = file,
                        out = paste(output, filename, ".pdf", sep=""),
                        fastq=TRUE)
    
    print(paste("Length distribution histogram created for ", filename, sep=""))
    
  }#close for loop
  }#close function
  
  #DADA2_Workflow/_Length_distribution_cutadapt/

length_dist_plot(filepath = "DADA2_Workflow/ForFiles_Cutadapt/_data", output = "DADA2_Workflow/ForFiles_Cutadapt/_Length_distribution_cutadapt/")

## If function isn't working:
#     - Make sure input and output file paths are correct
#     - Make sure output file path is created
#     - Make sure split input is segmenting the file names in the correct spot 