# Change p 0.01 to 0.5
output_basedata_pathway='/staging2/reserve/flagship/u3121714/kenny/Output/Basedata/'
phenoarray=HBOC_110
# --------------------------------------------------
cd ${output_basedata_pathway}$phenoarray
# Remove effect size = NA
awk '$11 !~ /NA/' finalBase.txt > finalBase_noNA.txt

# Extract header
head -n1 finalBase_noNA.txt > finalBase_noNA_header.txt
sed -i 's/BP/POS/g' finalBase_noNA_header.txt
awk '{printf $1"\t"$3"\t"$4"\t"$7"\t"$9"\t"$11"\n"}' finalBase_noNA_header.txt > finalBase_noNA_header_cor.txt

# Filter p <= 0.5, keep CHR, POS, A1, A2, P, EFFECT_SIZE
awk '$9 <= 0.5 {printf $1"\t"$3"\t"$4"\t"$7"\t"$9"\t"$11"\n"}' finalBase_noNA.txt > SNP_p_0.5_noheader.txt

# combine header into SNP list
cat finalBase_noNA_header_cor.txt SNP_p_0.5_noheader.txt > SNP_p_0.5.txt
