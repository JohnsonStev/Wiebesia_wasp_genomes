# index
hisat2-build $genome gatk_updated_pilon6_namechanged_254.fasta

# run hisat mapping
hisat2  $genome -1 $rawseq_dir/Sample5_L1_I364.R1.clean.fastq.gz -2 $rawseq_dir/Sample5_L1_I364.R2.clean.fastq.gz -S sample5.sam

# convert sam to bam
for i in *.sam; 
do samtools sort $i -o $i.sorted.bam; done

# stringtie assembly
for i in *.sorted.bam;
do stringtie $i; done


# merge stringtie results from each library
ls *gtf > gtf.list.txt
stringtie --merge -o stringtie_merged.gtf gtf.list.txt


# run transdecoder pipeline for ORF prediction
$transdecoder/util/cufflinks_gtf_genome_to_cdna_fasta.pl stringtie_merged.gtf gatk_updated_pilon6_namechanged_254.fasta > transcripts.fasta
$transdecoder/util/cufflinks_gtf_to_alignment_gff3.pl stringtie_merged.gtf > stringtie_merged.gff3
$transdecoder/TransDecoder.LongOrfs -S -t transcripts.fasta

$transdecoder/TransDecoder.Predict -t transcripts.fasta --retain_blastp_hits blastp.filter.outfmt6
$transdecoder/util/cdna_alignment_orf_to_genome_orf.pl transcripts.fasta.transdecoder.gff3 stringtie_merged.gff3 transcripts.fasta > stringtie_merged.predict.gff3

