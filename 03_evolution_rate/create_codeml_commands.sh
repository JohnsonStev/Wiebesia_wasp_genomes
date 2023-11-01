while read line; do
echo "cd $current_dir" >> commands.sh
echo "mkdir $line" >> commands.sh
echo "cd $line" >> commands.sh
echo "ln -s $seq_dir/$line.aligned.paml.best.phy.fna.fas-gb1.paml.phy $line.paml" >> commands.sh
echo "sed s/all.paml/$line.paml/ ../../codeml-M0_m-2.ctl > ${line}_codeml-M0.ctl" >> commands.sh
echo "codeml ${line}_codeml-M0.ctl"  >> commands.sh
done < $gene_list
