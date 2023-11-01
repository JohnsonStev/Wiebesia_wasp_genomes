bwa mem -t 25 $ref $read1 $read2 | samtools sort > CW_raw.vs.${ref}.bam
bam=CW_raw.vs.${ref}.bam
samtools index $bam
#java -Xmx240G -jar pilon-1.22.jar --genome $ref --frags $bam --output pilon2 --fix all --mindepth 0.5 --changes --verbose --threads 25
