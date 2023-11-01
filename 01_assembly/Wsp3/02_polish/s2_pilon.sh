bwa index wasp.consensus.fasta

bwa mem -t 20 wasp.consensus.fasta output_forward_paired.fq.gz output_reverse_paired.fq.gz | samtools sort > trimmedclean.vs.wasp.consensus.sorted.bam

samtools index trimmedclean.vs.wasp.consensus.sorted.bam
samtools faidx wasp.consensus.fasta

java -Xmx80G -jar pilon-1.22.jar --genome wasp.consensus.fasta --frags trimmedclean.vs.wasp.consensus.sorted.bam --output pilon1 --fix all --mindepth 0.5 --changes
