# make bw files for mapped bam  <deeptools>

bamCoverage --bam a.bam -o a.SeqDepthNorm.bw --binSize 1 --normalizeUsing CPM
