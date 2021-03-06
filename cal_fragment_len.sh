samtools  view Tn5-Input.sorted.bam | \
awk -F'\t' 'function abs(x){return ((x < 0.0) ? -x : x)} {print $1"\t"abs($9)}' | \
sort | uniq | cut -f2 > fragment.input.length.txt


##############################################################

data <- read.table("fragment.length.txt", header = F)
# 设置插入片段长度的阈值，过滤掉太长的片段
length_cutoff <- 1200
fragment <- data$V1[data$V1 <= length_cutoff]
# 利用直方图统计频数分布，设置柱子个数
breaks_num <- 500
res <- hist(fragment, breaks = breaks_num, plot = FALSE)
# 添加坐标原点
plot(x = c(0, res$breaks),
     y = c(0, 0, res$counts) / 10^2,
     type = "l", col = "red",
     xlab = "Fragment length(bp)",
     ylab = expression(Normalized ~ read ~ density ~ 10^2),
     main = "Sample Fragment sizes")
