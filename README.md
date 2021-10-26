# **edna_metabarcoding**
Repository for eDNA metabarcoding pipeline from raw data to workable seq data for analysis. The goal for this repo is to host the general software pipeline for eDNA metabarcoding, and then to be called upon from other repos for project-specific output.

**This repo contains the workflow for processing MiSeq metabarcoding data.** It will demultiplex samples, merge pair-ended reads, remove primer sequences, filter sequences, and create OTUs.

# General Workflow

  1. De-multiplex MiSeq data
  2. Merge pair-end reads and construct reverse complement
  3. Trim primer sequences
  4. Remove sequences of unexpected length
  5. Remove reads with high expected error
  6. Cluster sequences into OTUs
  7. Fiter out highly rare OTUS


***

# Where this software comes from
This workflow is an adapted version of the [JAMP R software from Elbrecth et al (2018)](https://github.com/VascoElbrecht/JAMP). JAMP relies on the following command-line tools: USearch, VSearch, Cutadapt, and FastQC.
