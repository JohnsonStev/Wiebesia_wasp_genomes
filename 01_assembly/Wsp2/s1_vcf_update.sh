genome=W_sp3_genome
#mapping
bwa mem -t 15 $genome $reads | samtools sort > updated_pilon6.vs.CW.filtered_sorted.bam
bam=updated_pilon6.vs.CW.filtered_sorted.bam
samtools index $bam

#calling variants
samtools mpileup -C50 -uf $genome $bam | bcftools call -c >updated_before_vcfutils.vcf

#calling consensus based on coverage (1/3X ~ 2X mean depth) #
vcfutils.pl vcf2fq -d 25 -D 150 updated_before_vcfutils.vcf | seqtk seq -a > CW_updated.fa
