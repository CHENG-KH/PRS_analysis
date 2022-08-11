path_to_output_folder="/home/kenny77527/"
cel_list_file="TV2W_20213612G_0EJ_TWB2.CEL"
analysis_files_path="/home/kenny77527/"

/NovaSeq_127/digi_2022/Kenny/Input/tool/bin/apt-probeset-genotype \
  --analysis-files-path $analysis_files_path \
  --xml-file GenomeWideSNP_6.apt-probeset-genotype.AxiomGT1.xml \
  --out-dir $path_to_output_folder \
  --cel-files $cel_list_file \
  --special-snps GenomeWideSNP_6.specialSNPs \
  --chip-type GenomeWideEx_6 \
  --chip-type GenomeWideSNP_6 \
  --table-output false \
  --cc-chp-output \
  --write-models \
  --read-models-brlmmp GenomeWideSNP_6.generic_prior.txt
