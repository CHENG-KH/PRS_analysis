for file in *.vcf*; do
  for sample in `/staging2/reserve/flagship/u3121714/kenny/Input/Script/bin/bcftools view -h $file | grep "^#CHROM" | cut -f10-`; do
    /staging2/reserve/flagship/u3121714/kenny/Input/Script/bin/bcftools view -c1 -Oz -s $sample -o $sample.vcf.gz $file
  done
done
