#!/bin/bash
finalBase='/staging2/reserve/flagship/u3121714/kenny/Output/Basedata/HBOC_200/'

#============================以下不要動===============================

# Sort finalBase.txt
sort -k11,11 -n ${finalBase}finalBase.txt > ${finalBase}finalBase_sort.txt

# Remove logOR with NA
sed '/NA/d' ${finalBase}finalBase_sort.txt > ${finalBase}finalBase_sort_noNA.txt

# Extract top 100
head -n 101 ${finalBase}finalBase_sort_noNA.txt > ${finalBase}HBOC_effect_logOR.txt
