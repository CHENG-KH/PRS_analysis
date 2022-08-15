#!/bin/bash
filename='HBOC.list'
current_dir='/home/kenny77527/HBOC/VCF/'

cd ${current_dir}

## Check for dir, if not found create it using the mkdir ##
create_dir="/home/kenny77527/HBOC/recode_vcf/"
[ ! -d "$create_dir" ] && mkdir -p "$create_dir"
output_path=${create_dir}


while IFS='' read -r line || [[ -n "$line" ]]; do
	# Check file exist or not
        echo "==> $line"
        echo -e "`ls ${current_dir} | grep ${line}`"
	# Modify : --vcf
	/NovaSeq_127/digi_2022/Kenny/Input/tool/bin/vcftools --vcf "${current_dir}${line}".vcf --recode --recode-INFO-all \
		--out ${output_path}${line}_DP10_MAF21.vcf \
		--chr chr1 --chr chr2 --chr chr3 --chr chr4 --chr chr5 --chr chr6 --chr chr7 --chr chr8 --chr chr9 --chr chr10 --chr chr11 --chr chr12 --chr chr13 --chr chr14 --chr chr15 --chr chr16 --chr chr17 --chr chr18 --chr chr19 --chr chr20 --chr chr21 --chr chr22 --chr chrX --chr chrY --chr chrM \
		--min-meanDP 10 \
		--non-ref-af-any 0.21
done < $filename


#Merge all VCF
merge_filename='merge_HBOC.list'

## Check for dir, if not found create it using the mkdir ##
merge_dir='/home/kenny77527/HBOC/VCF_merge/'
[ ! -d "$merge_dir" ] && mkdir -p "$merge_dir"
merge_output_path=${merge_dir}

disease='HBOC'
Amount_of_Samples='10'

# move.log file to log file
cd ${create_dir}
mkdir ../log
mv *.log ../log
mv ${merge_filename} ${merge_dir}

# Build 'merge_HBOC_48.list'
ls ${create_dir} > ${merge_dir}${merge_filename}
mv ${merge_dir}${merge_filename} ${create_dir}

while IFS='' read -r line || [[ -n "$line" ]]; do
	# Check file exist or not
        echo "==> $line"
        echo -e "`cat ${create_dir}${merge_filename} | grep ${line}`"
	# Make VCF.gz and index
	/NovaSeq_127/digi_2022/Kenny/Input/tool/bin/bgzip -c "${create_dir}${line}" > "${create_dir}${line}".gz
  /NovaSeq_127/digi_2022/Kenny/Input/tool/bin/tabix -p vcf "${create_dir}${line}".gz
done < ${merge_filename}

# Build list for merging, with route and .gz in the end
sed -e 's/^GSL/\/home\/kenny77527\/HBOC\/recode_vcf\/GSL/' -i ${create_dir}${merge_filename}
sed -e 's/^GYN/\/home\/kenny77527\/HBOC\/recode_vcf\/GYN/' -i ${create_dir}${merge_filename}
sed -e 's/$/.gz/' -i ${create_dir}${merge_filename}

#Merge VCF.gz
/NovaSeq_127/digi_2022/Kenny/Input/tool/bin/bcftools merge -0 -l ${create_dir}${merge_filename} --threads 50 --force-samples -Ov -o ${merge_output_path}${disease}_${Amount_of_Samples}.merge.vcf