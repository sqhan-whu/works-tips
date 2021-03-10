具体操作如下：

下载文件：rmsk.txt.gz （27-Apr-2009 14:55 137M）
文件链接：http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/

      解压后运行：
grep LINE rmsk.txt | awk -F"\t" '{print $6,$7,$8,$10}' |sed 's/ /\t/g'>LINE.bed

grep Simple_repeat rmsk.txt |awk  -F"\t" '{print $6,$7,$8,$10}'|sed 's/ /\t/g' >Simple_repeat.bed

grep SINE rmsk.txt |awk  -F"\t" '{print $6,$7,$8,$10}' |sed 's/ /\t/g'>SINE.bed

grep LTR rmsk.txt |awk  -F"\t" '{print $6,$7,$8,$10}'|sed 's/ /\t/g'>LTR.bed

grep DNA rmsk.txt |awk  -F"\t" '{print $6,$7,$8,$10}'|sed 's/ /\t/g'>DNA.bed

grep Satellite rmsk.txt |awk  -F"\t" '{print $6,$7,$8,$10}'|sed 's/ /\t/g'>Satellite.bed

grep Low_complexity rmsk.txt |awk  -F"\t" '{print $6,$7,$8,$10}'|sed 's/ /\t/g'>Low_complexity.bed
################
输出结果：
第一列为染色体信息
第二列为起点
第三列为重点
第四列为标注的正负链
第五列为分类名称
