#########  stringtie  call  fpkm 
#!/bin/bash
#SBATCH -N 1 -c 10
stringtie -p 10 -e -G ~/project/00.DATABASE/GRmm38/Annotation/mRNA/gencode.vM24.annotation.gtf -o F-2-1.sorted.bam.filter.bam.gtf F-2-1.sorted.bam.filter.bam
stringtie -p 10 -e -G ~/project/00.DATABASE/GRmm38/Annotation/mRNA/gencode.vM24.annotation.gtf -o F-2-2.sorted.bam.filter.bam.gtf F-2-2.sorted.bam.filter.bam
stringtie -p 10 -e -G ~/project/00.DATABASE/GRmm38/Annotation/mRNA/gencode.vM24.annotation.gtf -o F-2-3.sorted.bam.filter.bam.gtf F-2-3.sorted.bam.filter.bam
stringtie -p 10 -e -G ~/project/00.DATABASE/GRmm38/Annotation/mRNA/gencode.vM24.annotation.gtf -o F-2-4.sorted.bam.filter.bam.gtf F-2-4.sorted.bam.filter.bam


###### sort by ID
for i in `ls *.gtf`;do echo "grep -w FPKM $i |cut -f 4,10 -d '\"' |tr '\"' '\t' |sort -k1 > $i.fpkm";done |sh


##### pulldown fpkm cor
paste F-2-3.sorted.bam.filter.bam.gtf.fpkm F-2-4.sorted.bam.filter.bam.gtf.fpkm |cut -f 1,2,4|awk '{if($2>=0.1&&$3>=0.1)print $0}' | sed '1iid\tfpkm1\tfpkm2' > pulldown.fpkm.txt

##### control fpkm cor
paste F-2-1.sorted.bam.filter.bam.gtf.fpkm F-2-2.sorted.bam.filter.bam.gtf.fpkm |cut -f 1,2,4|awk '{if($2>=0.1&&$3>=0.1)print $0}' | sed '1iid\tfpkm1\tfpkm2' > control.fpkm.txt



#######################  ggplot2 scatter plot ##############
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
data = read.table("control.fpkm.txt",head=T)
data2 = read.table("pulldown.fpkm.txt",head=T)

g1=ggplot(data=data, aes(x=log(fpkm1,2), y=log(fpkm2,2))) +
  geom_point(color="#8172B2",alpha=1,size = 0.5) +
  xlab("Rep1 log2(FPKM)") + ylab("Rep2 log2(FPKM)") +   #定义X轴和Y轴的名称,size = 4
  xlim(0, 20) +   ylim(0, 20) + 
  theme_bw(base_size=15)+   #去除灰色背景并设置字体大小
 # geom_abline (intercept=0,slope=1 )+
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))+ #去除背景格线
  #labs(title = "RT-stop reads distribution")+    #设置标题
  theme(plot.title = element_text(size=15,hjust = 0.3),legend.position='top')+
  annotate("text", x = 5, y = 12, label = paste("r",round(cor(data$fpkm1,data$fpkm2),4),sep="="))+
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

ggsave(g1,file="control.png",width = 5.5,height = 5.5)
#
g2=ggplot(data=data2, aes(x=log(fpkm1,2), y=log(fpkm2,2))) +
  geom_point(color="#8172B2",alpha=1,size = 0.5) +
  xlab("Rep1 log2(FPKM)") + ylab("Rep2 log2(FPKM)") +   #定义X轴和Y轴的名称,size = 4
  xlim(0, 20) +   ylim(0, 20) + 
  theme_bw(base_size=15)+   #去除灰色背景并设置字体大小
 # geom_abline (intercept=0,slope=1 )+
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"))+ #去除背景格线
 # labs(title = "RT-stop reads distribution")+    #设置标题
  theme(plot.title = element_text(size=15,hjust = 0.3),legend.position='top')+
  annotate("text", x = 5, y = 12, label = paste("r",round(cor(data2$fpkm1,data2$fpkm2),4),sep="="))+
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

ggsave(g2,file="pulldown.png",width = 5.5,height = 5.5)
