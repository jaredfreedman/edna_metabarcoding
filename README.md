# **edna_metabarcoding**
Repository for eDNA metabarcoding pipeline from raw data to workable seq data for analysis.

**This repo contains the workflow for processing MiSeq metabarcoding data.** It will demultiplex samples, merge pair-ended reads, remove primer sequences, filter sequences, and create OTUs. The goal for this repo is to host the general software pipeline for eDNA metabarcoding, and then to be called upon from other repos for project-specific output.

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
This workflow is an adapted version of the [JAMP R software from Elbrecth et al (2018)](https://github.com/VascoElbrecht/JAMP). JAMP relies on the following command-line tools: 
* [USearch v11 32bit](https://www.drive5.com/usearch/manual/) (*note: 32bit does not work on MacOS Big Sur*)
* [VSearch v2.6.2 ](https://github.com/torognes/vsearch)(*note: this is not the most up-to-date version*)
* [Cutadapt v3.5](https://cutadapt.readthedocs.io/en/stable/installation.html)
* [FastQC v0.11.9](https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc).
