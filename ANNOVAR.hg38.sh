solve 3 problem:
1. sites  filter snp
2. get sites location region (UTR/CDS/intron and so on)
3. get mutation type for coden sequence

### how to use ANNOVAR for sites annotation.  example for mm10  ensGene VM24 version
### 0. download mm10 database

#perl annotate_variation.pl -buildver mm10 -downdb -webfrom annovar refGene GRmm38db/
### change refGene to ensGene
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/wgEncodeGencodeBasicV31.txt.gz
# gunzip wgEncodeGencodeBasicV31.txt.gz
#mv wgEncodeGencodeBasicV31.txt hg38_ensGene.txt
perl annotate_variation.pl --buildver hg38 --downdb seq hg38db/hg38_seq

#perl retrieve_seq_from_fasta.pl hg38db/mm10_refGene.txt -seqdir GRmm38db/mm10_seq -format refGene -outfile GRmm38db/mm10_refGeneMrna.fa

perl retrieve_seq_from_fasta.pl hg38db/hg38_ensGene.txt -seqdir hg38db/hg38_seq -format ensGene -outfile hg38db/hg38_refGeneMrna.fa
### same as above 
#perl retrieve_seq_from_fasta.pl -format genericGene -seqfile GRmm38db/mm10_seq/mm10.fa -outfile GRmm38db/mm10_wgEncodeGencodeBasicVM24Mrna.fa GRmm38db/mm10_ensGene.txt

### download hg38 snp database Version snp151;  2 type snp,  total snp / Common snp  ~  10 / 1,     Common recommend

perl annotate_variation.pl -downdb -buildver hg38 -webfrom ucsc snp151Common GRmm38db

### download hg38 region phastConsElements60way 
perl annotate_variation.pl -build hg38 -downdb phastConsElements100way GRmm38db/ 
#####################################################################################################################
1. sites  filter snp
cd ~/scratch/20201122_A_I/HISAT2/process/mutation/ANNOVAR
#perl ~/project/opt/annovar/annotate_variation.pl -filter -out out.common -build mm10 -dbtype snp142 annovar.36546.input ~/project/opt/annovar/GRmm38db
perl ~/project/opt/annovar/annotate_variation.pl -filter -out out.common -build mm10 -dbtype snp142Common annovar.36546.input ~/project/opt/annovar/GRmm38db

2. get sites location region (UTR/CDS/intron and so on)

perl ~/project/opt/annovar/annotate_variation.pl -out test -dbtype ensGene -build mm10 out.common.mm10_snp142Common_filtered ~/project/opt/annovar/GRmm38db

3. get mutation tyope for coden sequence

cat test.exonic_variant_function |perl -p -e 's/p./ /g' |tr ' ' '\n' |tr ',' '\n' |awk '{print $1}' |grep -P "^\w\d+\w$"|perl -p -e 's/\d+//g' |sort|uniq -c |sort -k1nr|awk '{print $2"\t"$1}'
