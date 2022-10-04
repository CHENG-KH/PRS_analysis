library(dplyr)
library(stringr)
library(tidyr)

setwd('/Volumes/Kenny/PRS_analysis/Count_PGS_score')

Score <- read.table("HBOC_313_adjusted.txt", header = T, stringsAsFactors = FALSE)

# Make all VCF lists
ff <- list.files(path="/Volumes/Kenny/PRS_analysis/Count_PGS_score/VCF", full.names=TRUE)
myfilelist <- lapply(ff, read.table, header = TRUE, fill = TRUE, stringsAsFactors = FALSE)
names(myfilelist) <- list.files(path="/Volumes/Kenny/PRS_analysis/Count_PGS_score/VCF", full.names=FALSE)

# Count scores
for (i in 1:length(myfilelist)) {
  Innerjoin <- Score %>%
    inner_join(myfilelist[[i]], by = c("Chr" = "CHROM", "POS", "REF"), suffix = c("_pgs", "_vcf"))
  # replace NA with not match
  Innerjoin[, 6] <- str_match(Innerjoin[, 6], Innerjoin[, 4])
  # remove ALT_vcf = NA
  Innerjoin <- drop_na(Innerjoin)
  # Calculate score
  score <- Innerjoin %>%
    mutate(count_allele = case_when(
      str_count(Innerjoin[ , 7], "0") == 1 ~ 1,
      str_count(Innerjoin[ , 7], "0") == 0 ~ 2,
    ), score = OR * count_allele) %>%
    summarize(sum(score))
  write(paste(names(myfilelist[[i]][5]), sum(score), sep = "\t"), file = "score_list.csv", append = TRUE)
}
