EVM_home=EVidenceModeler-1.1.1

$EVM_home/EvmUtils/partition_EVM_inputs.pl --genome ../gatk_updated_pilon6_namechanged_254.fasta \
   --gene_predictions ../gene_predictions.gff3 --protein_alignments ../protein_alignments.gff3 \
  --transcript_alignments ../transcript_alignments.gff3 \
 --segmentSize 100000 --overlapSize 10000 --partition_listing partitions_list.out

$EVM_home/EvmUtils/write_EVM_commands.pl --genome  ../gatk_updated_pilon6_namechanged_254.fasta --weights `pwd`/weight.txt \
 --gene_predictions ../gene_predictions.gff3 --protein_alignments ../protein_alignments.gff3 \
  --transcript_alignments ../transcript_alignments.gff3 \
 --output_file_name evm.out  --partitions partitions_list.out >  commands.list

perl /p200/wuzhy_group/bigwenyl/bin/split_file_qsub.pl -num 77 -pre EVM -out EVM.shell -queue geneque -sin_ppn 1 -all_ppn 5 -link 1 -mem 6gb commands.list

$EVM_home/EvmUtils/recombine_EVM_partial_outputs.pl --partitions partitions_list.out --output_file_name evm.out
$EVM_home/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out --output evm.out  --genome ../gatk_updated_pilon6_namechanged_254.fasta
find . -regex ".*evm.out.gff3" -exec cat {} \; > EVM.all.gff3
