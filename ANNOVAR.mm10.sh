solve 3 problem:
1. sites  filter snp
2. get sites location region (UTR/CDS/intron and so on)
3. get mutation type for coden sequence

### how to use ANNOVAR for sites annotation.  example for mm10  ensGene VM24 version
### 0. download mm10 database

#perl annotate_variation.pl -buildver mm10 -downdb -webfrom annovar refGene GRmm38db/
### change refGene to ensGene
# wget http://hgdownload.cse.ucsc.edu/goldenPath/mm10/database/wgEncodeGencodeBasicVM24.txt.gz
# gunzip wgEncodeGencodeBasicVM24.txt.gz 
#mv wgEncodeGencodeBasicVM24.txt mm10_ensGene.txt

perl annotate_variation.pl --buildver mm10 --downdb seq GRmm38db/mm10_seq

#perl retrieve_seq_from_fasta.pl GRmm38db/mm10_refGene.txt -seqdir GRmm38db/mm10_seq -format refGene -outfile GRmm38db/mm10_refGeneMrna.fa

perl retrieve_seq_from_fasta.pl GRmm38db/mm10_ensGene.txt -seqdir GRmm38db/mm10_seq -format ensGene -outfile GRmm38db/mm10_refGeneMrna.fa
### same as above 
#perl retrieve_seq_from_fasta.pl -format genericGene -seqfile GRmm38db/mm10_seq/mm10.fa -outfile GRmm38db/mm10_wgEncodeGencodeBasicVM24Mrna.fa GRmm38db/mm10_ensGene.txt

### download mm10 snp database Version snp142;  2 type snp,  total snp / Common snp  ~  10 / 1,     Common recommend
#perl annotate_variation.pl -downdb -buildver mm10 -webfrom ucsc snp142 GRmm38db
perl annotate_variation.pl -downdb -buildver mm10 -webfrom ucsc snp142Common GRmm38db

### download mm10 region phastConsElements60way 
perl annotate_variation.pl -build mm10 -downdb phastConsElements60way GRmm38db/ 
#####################################################################################################################
1. sites  filter snp
cd ~/scratch/20201122_A_I/HISAT2/process/mutation/ANNOVAR
#perl ~/project/opt/annovar/annotate_variation.pl -filter -out out.common -build mm10 -dbtype snp142 annovar.36546.input ~/project/opt/annovar/GRmm38db
perl ~/project/opt/annovar/annotate_variation.pl -filter -out out.common -build mm10 -dbtype snp142Common annovar.36546.input ~/project/opt/annovar/GRmm38db

2. get sites location region (UTR/CDS/intron and so on)

perl ~/project/opt/annovar/annotate_variation.pl -out test -dbtype ensGene -build mm10 out.common.mm10_snp142Common_filtered ~/project/opt/annovar/GRmm38db

3. get mutation tyope for coden sequence

cat test.exonic_variant_function |perl -p -e 's/p./ /g' |tr ' ' '\n' |tr ',' '\n' |awk '{print $1}' |grep -P "^\w\d+\w$"|perl -p -e 's/\d+//g' |sort|uniq -c |sort -k1nr|awk '{print $2"\t"$1}'
