library(dplyr)
library(stringr)
library(tidyr)
library(data.table)
library(tidyverse)
library(readxl)

setwd('/Volumes/Kenny/PRS_analysis/Count_PGS_score')

GRCh38 <- read.table("hglft_genome_44c5_7ad530.bed", header=F, col.names = "chrom_position") %>%
  separate(chrom_position, c("chr_38", "position_38"))

GRCh37 <- read.table("PGS002701.txt", header=T)
  #filter(chr_position != 149772504 & chr_position != 147124960 & chr_position != 147096828 
         #& chr_position != 147125034 & chr_position != 147125035 & chr_position != 120648690  
         #& chr_position != 36165777 & chr_position != 195198871 & chr_position != 195199114
         #& chr_position != 74212351 & chr_position != 75039300 & chr_position != 74331032
         #& chr_position != 142644521 & chr_position != 142274535 & chr_position != 72282356 
         #& chr_position != 72319016 & chr_position != 75052079 & chr_position != 74369799 
         #& chr_position != 56977671 & chr_position != 74281762 & chr_position != 74867733 
         #& chr_position != 64718550 & chr_position != 136145404 & chr_position != 49201964 
         #& chr_position != 17960098 & chr_position != 132834983 & chr_position != 34358839 
         #& chr_position != 72335022 & chr_position != 7396263 & chr_position != 8788341 
         #& chr_position != 11535597 & chr_position != 55193414 & chr_position != 42537271 
         #& chr_position != 23412017 & chr_position != 22694294 & chr_position != 22609433 
         #& chr_position != 48050396)
GRCh37_missing <- read.table("PGS002701_GRCh37_missing.txt", header=F, col.names = "chrom_position") %>%
  separate(chrom_position, c("chr_name", "chr_position")) %>%
  mutate(chr_position = as.integer(chr_position)) 
GRCh37_missing$chr_name <- as.integer(sub("chr", "", GRCh37_missing$chr_name))

GRCh37 <- GRCh37 %>%
  anti_join(GRCh37_missing, by = c("chr_name", "chr_position"))
  
GRCh37_38 <- bind_cols(GRCh37, GRCh38) %>%
  select("Chr" = "chr_38", "POS" = "position_38", "REF" = "effect_allele", "ALT" = "other_allele", "OR" = "effect_weight") %>%
  mutate(POS = as.integer(POS))

#HBOC_313 <- read_excel("41467_2020_17680_MOESM4_ESM.xlsx", col_names = FALSE, skip = 2) %>%
  #select(`...2`, `...3`, `...4`, `...11`) %>%
  #rename("Chr" = `...2`, "POS" = `...3`, "Allele" = `...4`, "OR" = `...11`) %>%
  #full_join(GRCh37_38_313, by = c("POS" = "position_37")) %>%
  #drop_na() 

#HBOC_313_adjusted <- HBOC_313 %>%
  #select(Chr, POS = position_38, Allele, OR)

#HBOC_313_adjusted <- HBOC_313_adjusted[HBOC_313_adjusted$OR != "NA", ]

#HBOC_313_adjusted$Chr <- sub("^", "chr", HBOC_313_adjusted$Chr)
#HBOC_313_adjusted$OR <- substr(HBOC_313_adjusted$OR, 1, 4) %>%
 # as.numeric() %>%
  #log()

#HBOC_313_adjusted <- HBOC_313_adjusted %>%
 # mutate(ALT = Allele) %>%
  #rename(REF = Allele) %>%
 # select(Chr, POS, REF, ALT, OR)

#HBOC_313_adjusted$REF <- str_replace(HBOC_313_adjusted$REF, pattern = "/[:alpha:]*", replacement = "")
#HBOC_313_adjusted$ALT <- str_replace(HBOC_313_adjusted$ALT, pattern = "[:alpha:]*/", replacement = "")

write.table(GRCh37_38, file = "/Volumes/Kenny/PRS_analysis/Count_PGS_score/hypertension_adjusted.txt", sep = "\t", row.names=F, col.names=T)
 