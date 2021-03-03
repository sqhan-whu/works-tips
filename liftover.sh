#########
Chain files from hg38 (GRCh38) to hg19 and all other organisms: http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/
Chain File from hg19 (GRCh37) to hg17/hg18/hg38 and all other organisms: http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/
Chain File from mm10 (GRCm38) to mm9 and all other organisms: http://hgdownload.soe.ucsc.edu/goldenPath/mm10/liftOver/

#### download translation files
http://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz

##需求hg19转化成hg38版本
 gunzip hg19ToHg38.over.chain.gz  #解压chain文件
/home/soft/liftOver /home/data/all.mp.hg19.bed /home/soft/hg19ToHg38.over.chain all.mp.hg19tohg38.bed unmapped
#liftOver [1] [2] [3] [4] 
# bed chr1  100  101
#[1] 需要转换的文件
#[2] chain文件
#[3] 转换后的文件
#[4] 转换不成功的部分
