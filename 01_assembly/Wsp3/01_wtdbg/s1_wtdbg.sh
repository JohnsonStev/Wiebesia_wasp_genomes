#wtdbg-1.2.8/map2dbgcns
### assembling
wtdbg-1.2.8 -t 50 -i merged_all_filterd.fa --tidy-reads 5000 -fo wasp.wtdbg -k 0 -p 21 -S 4 --edge-min 4
### first round of correction
wtdbg-cns -t 50 -i wasp.wtdbg.ctg.lay -fo wasp.wtdbg.ctg.lay.fa -c 0
### mapping
kbm-1.2.8 -t 50 -d wasp.wtdbg.ctg.lay.fa -i merged_all_filterd.fa -k 0 -p 21 -S 4 -O 0 | best_kbm_hit.pl | awk '{print $6"\t"$9"\t"$10"\t"$1"\t"$2"\t"$4"\t"$5}' >wasp.wtdbg.map
### generating new layout
map2dbgcns wasp.wtdbg.ctg.lay.fa merged_all_filterd.fa wasp.wtdbg.map >wasp.wtdbg.map.lay
### second round of correction
wtdbg-cns -t 50 -i wasp.wtdbg.map.lay -fo wasp.wtdbg.map.fa -k 13 -c 3
