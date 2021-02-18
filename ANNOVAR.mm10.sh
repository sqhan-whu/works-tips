### how to use ANNOVAR for sites annotation.  example for mm10  ensGene VM24 version
### 1. download mm10 database

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

### 1.2 download mm10 snp database Version snp142;  2 type snp,  total snp / Common snp  ~  10 / 1,     Common recommend
#perl annotate_variation.pl -downdb -buildver mm10 -webfrom ucsc snp142 GRmm38db
perl annotate_variation.pl -downdb -buildver mm10 -webfrom ucsc snp142Common GRmm38db

cd ~/scratch/20201122_A_I/HISAT2/process/mutation/ANNOVAR
#perl ~/project/opt/annovar/annotate_variation.pl -filter -out out.common -build mm10 -dbtype snp142 annovar.36546.input ~/project/opt/annovar/GRmm38db
perl ~/project/opt/annovar/annotate_variation.pl -filter -out out.common -build mm10 -dbtype snp142Common annovar.36546.input ~/project/opt/annovar/GRmm38db
