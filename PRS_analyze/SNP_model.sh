
output_basedata_pathway='/staging2/reserve/flagship/u3121714/kenny/Output/Basedata/'
phenoarray=HBOC_110
# --------------------------------------------------
cd ${output_basedata_pathway}$phenoarray
# Remove effect size = NA
awk '$11 !~ /NA/' finalBase.txt > finalBase_noNA.txt

# Filter p <= 0.01, keep CHR, POS, A1, A2, P, EFFECT_SIZE
awk '$9 <= 0.01 {printf $1"\t"$3"\t"$9"\t"$11"\n"}' finalBase_noNA.txt > SNP_p_0.01.txt
