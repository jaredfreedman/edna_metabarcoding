# Create Lenght Distribution plots for trimmed sequences

# Clear workspace and close all graphics devices --------------------------

rm(list = ls())
graphics.off()

# set working directory to proper repo

library(JAMP)
setwd("/Users/jaredfreedman/Research/git/edna_metabarcoding/GC_VR_MiSeq_2021")


# Create new directory for files -----------------------------------------

dir.create("_Length_distribution", 
           path = "DADA2_Workflow/_Length_distribution")


# For loop that creates length dist plot for each file from C_cuta --------



trimmed_files <- list.files(path = "demulti_fastq/_Data", full.names = TRUE) # Create list of file names
nfile <- length(trimmed_files)
ifile <- 1

start_time <- Sys.time() # start timer to see how long the following for loop will take

#for(ifile in 1:nfile){
  
  file <- trimmed_files[ifile]   #create character string containing the file path and name
  filename <- strsplit(trimmed_files[ifile], split=".fastq")[[1]]   #create character string that contains file name without _PE_cut or .fastq extention
  filename <- strsplit(filename, split="/")[[1]][3]   #remove the file path from the filename (done by splitting string by /, and only taking the 3rd part)
  
  
  Length_distribution(sequFile = file,
                      out = paste("C_Cutadapt/_stats/_Length_distribution/", filename, ".pdf", sep=""),
                      fastq=TRUE)
  
  print(paste("Length distribution histogram created for ", filename, sep=""))
  
#}

end_time <- Sys.time() # end timer once for loop is completed

end_time - start_time
