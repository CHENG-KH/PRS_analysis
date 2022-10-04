library(dplyr)
library(stringr)
library(data.table)

<<<<<<< HEAD:Count_PGS_score/GRCh37_to_38.R
setwd('/Volumes/Kenny/PRS_analysis/Count_PGS_score')

# Change format to suit for UCSC converting to GRCh38
GRCh37_313 <- fread("PGS000957.txt", header=T) %>%
=======
GRCh37_313 <- read.table("/Users/kenny/Desktop/PGS000004.txt", header=T) %>%
>>>>>>> parent of 1194adf (updated):exchange_referencepanel/GRCh37_to_38.R
  mutate_each(funs(prettyNum(., big.mark=","))) %>%
  mutate(chr_start = chr_position, chr_end = chr_position) %>%
  select(chr_name, chr_start, chr_end) 
#  filter(chr_name != "X" & chr_name != "MT" & chr_name != "XY")

# Add "chr" into chr_name column
GRCh37_313$chr_name <- sub("^", "chr", GRCh37_313$chr_name)

<<<<<<< HEAD:Count_PGS_score/GRCh37_to_38.R
write.table(paste0(GRCh37_313$chr_name, ':', GRCh37_313$chr_start, '-', GRCh37_313$chr_end), file = "GRCh37_PGS000957.txt", quote = FALSE, sep = "\t", row.names=F, col.names=F)
=======
write.table(paste0(GRCh37_313$chr_name, ':', GRCh37_313$chr_start, '-', GRCh37_313$chr_end), file = "/Users/kenny/Desktop/GRCh37_313.txt", quote = FALSE, sep = "\t", row.names=F, col.names=F)
>>>>>>> parent of 1194adf (updated):exchange_referencepanel/GRCh37_to_38.R
