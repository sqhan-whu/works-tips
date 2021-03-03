# make bw files for mapped bam  <deeptools>

bamCoverage --bam a.bam -o a.SeqDepthNorm.bw --binSize 1 --normalizeUsing CPM
bamCoverage --bam a.bam -o a.SeqDepthNorm.bw --binSize 1 --normalizeUsing RPKM
#!/bin/bash
plotProfile -m matrix.mat.point.3.gz --perGroup -out test.F.13.merge.pdf
plotHeatmap -m matrix.mat.point.3.gz --colorMap RdBu --whatToShow 'heatmap and colorbar' --zMin -3 --zMax 3 -out test.F.13.heatmap.pdf
plotProfile -m matrix.mat.point.4.gz --perGroup -out test.F.24.merge.pdf
plotHeatmap -m matrix.mat.point.4.gz --colorMap RdBu --whatToShow 'heatmap and colorbar' --zMin -3 --zMax 3 -out test.F.24.heatmap.pdf
#!/bin/bash
#computeMatrix scale-regions -S  F-2-1.sorted.bam.filter.bam.bw F-2-2.sorted.bam.filter.bam.bw F-2-3.sorted.bam.filter.bam.bw F-2-4.sorted.bam.filter.bam.bw  -R 36546.bed --beforeRegionStartLength 400 --afterRegionStartLength 400 --binSize 1 --skipZeros -o matrix.mat.gz
#computeMatrix reference-point -S F-2-1.sorted.bam.filter.bam.bw F-2-2.sorted.bam.filter.bam.bw F-2-3.sorted.bam.filter.bam.bw F-2-4.sorted.bam.filter.bam.bw -R 36546.bed -a 400 -b 400 -o matrix.mat.point.gz
computeMatrix reference-point -S F-2-1.sorted.bam.filter.bam.bw F-2-3.sorted.bam.filter.bam.bw -R 3.bed -a 400 -b 400 -o matrix.mat.point.3.gz
computeMatrix reference-point -S F-2-2.sorted.bam.filter.bam.bw F-2-4.sorted.bam.filter.bam.bw -R 4.bed -a 400 -b 400 -o matrix.mat.point.4.gz
