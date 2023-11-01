pbalign $subreads.bam wasp.wtdbg.map.fa $aligned.bam
ls *bam > sample.fofn
arrow -j25 -r ../wasp.wtdbg.map.fa -o wasp.variants.gff -o wasp.consensus.fasta -o wasp.consensus.fastq -p S/P2-C2/5.0 sample.fofn
