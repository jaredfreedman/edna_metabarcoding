# Install JAMP 

# Installing dependencies needed for JAMP
install.packages(c("bold", "XML", "seqinr", "devtools", "fastqcr"), dependencies=T)
# Load devtools and install package directly from GitHub
library("devtools")
install_github("VascoElbrecht/PrimerMiner", subdir="PrimerMiner")
install_github("tobiasgf/lulu")
install_github("VascoElbrecht/JAMP", subdir="JAMP")