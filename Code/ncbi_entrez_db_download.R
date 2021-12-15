## NCBI Entrez Database Download
# Created 12/13/21
# Updated 12/15/21


library(rBLAST)
library(rentrez)

rm(list = ls())
graphics.off()

setwd("Research/git/edna_metabarcoding/Taxonomy_Output")

# run an entrez search ----------------------------------------------------

query <- "cytochrome[All Fields] AND oxidase[All Fields] AND mitochondrion[Filter] AND animals[Filter] NOT \"Chordata\"[Organism]"
coi_entrez <- entrez_search(db="nuccore", #nucleotide database from NCBI (genbank, refseq, and more)
                            query, #search terms from above 
                            use_history = TRUE) #creates a web history object for faster downloads

search_size <- coi_entrez$count
print(paste("This search found", search_size, "matches"))

# This entrez search produces a list of unique identifiers for sequences that are found with the query search


# fetch FASTA based on entrez search --------------------------------------

start_time <- Sys.time() # start timer to see how long the following for loop will take

seqstart <- 1

# For loop to fetch 10,000 sequences in each batch (50,000 total)
for(seqstart in seq(1, 50000, 10000)){ 
  
  coi_db <- entrez_fetch(db="nuccore", #fetch sequnces from nuccore databse
                         web_history = coi_entrez$web_history, #web history object from entrez search
                         rettype = "fasta",
                         retmax = 10000,
                         retstart = seqstart)
  
  cat(coi_db, file = "coi_database_test.fasta", append = TRUE) #create fasta file with sequences from fetch, and append new sequences to file
  cat(seqstart+9999, "sequences downloaded\r") #print a status update each time through the for loop
}

end_time <- Sys.time() # end timer once for loop is completed
end_time - start_time
