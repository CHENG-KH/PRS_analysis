



awk '$11 !~ /NA/' finalBase.txt > finalBase_noNA.txt

awk '$9 <= 0.01 {printf $1"\t"$3"\t"$9"\t"$11"\n"}' finalBase_noNA.txt > SNP_p_0.01.txt
