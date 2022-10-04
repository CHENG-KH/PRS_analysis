# 註解掉的「程式碼」都可無視
library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggpubr)

setwd('/Users/kenny/Desktop')

# score density plot (雙峰圖)
base_pheno <- read.table("hypertension_base.txt", header = T, stringsAsFactors = FALSE) %>% 
  select("ID" = "FID", "PHENO" = "hypertension_216")
target_pheno <- read.table("hypertension_target.txt", header = T, stringsAsFactors = FALSE) %>% 
  select("ID" = "FID", "PHENO" = "hypertension")

base_score <- read.table("score_base_list.csv", col.names = c("ID", "SCORE"), stringsAsFactors = FALSE)
target_score <- read.table("score_target_list.csv", col.names = c("ID", "SCORE"), stringsAsFactors = FALSE)

pheno <- base_pheno %>%
  bind_rows(target_pheno)
score_pheno <- base_score %>%
  bind_rows(target_score) %>%
  full_join(pheno, by = "ID") %>%
  mutate(Standardized_Score = scale(SCORE)) %>%
  mutate(PHENO = case_when(
    PHENO == 1 ~ "Control",
    PHENO == 2 ~ "Case"
  )) %>%
  mutate(PHENO = factor(PHENO, levels = c("Control", "Case")))

gd <- ggdensity(score_pheno, x = "Standardized_Score",
   add = "mean", rug = TRUE,
   color = "PHENO", fill = "PHENO",
   palette = c("#0073C2FF", "#FC4E07"))+theme(legend.title=element_blank()) + ggtitle("Hypertension_PGS_score")

ggsave(plot = gd, filename=paste0("/Users/kenny/Desktop/Hypertension_PGS_score.tiff"), height = 4, width = 6)
