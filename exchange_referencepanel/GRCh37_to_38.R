library(dplyr)
library(stringr)

GRCh37_313 <- read.table("/Users/kenny/Desktop/PGS000004.txt", header=T) %>%
  mutate_each(funs(prettyNum(., big.mark=","))) %>%
  mutate(chr_start = chr_position, chr_end = chr_position) %>%
  select(chr_name, chr_start, chr_end)

GRCh37_313$chr_name <- sub("^", "chr", GRCh37_313$chr_name)

write.table(paste0(GRCh37_313$chr_name, ':', GRCh37_313$chr_start, '-', GRCh37_313$chr_end), file = "/Users/kenny/Desktop/GRCh37_313.txt", quote = FALSE, sep = "\t", row.names=F, col.names=F)
