#! /usr/bin/env bash

datasets='/Users/lkw/2016-GA-Workshop/data-sets/'

hg19fa="$datasets/fasta/hg19.chr22.fa"
H3K4me3="$datasets/bed/encode.h3k4me3.hela.chr22.bed.gz"
hg19bed="$datasets/bed/genes.hg19.bed.gz"
encode="$datasets/bed/encode.tfbs.chr22.bed.gz"
bedgraph="$datasets/bedtools/ctcf.hela.chr22.bg.gz"
hg19gen="$datasets/genome/hg19.genome"
TSS="$datasets/bed/tss.hg19.chr22.bed.gz"

# Question 1: Use bedtools intersect to ID size of
# largest overlap between CTCF and H3K4me locations
answer_1=$(bedtools intersect -a \
        <(gzcat $encode | awk '$4=="CTCF"') -b $H3K4me3 \
        | awk 'BEGIN{OFS="\t"} {print $3 - $2}' \
        | sort -nr \
        | head -n1)
 
echo "answer-1: $answer_1"

# Question 2: Use bedtools to calc the GC content of
# nucleotides 19,000,000 to 19,000,500 on chr22 of hg19
# genome build. Report the GC content as a fraction (e.g. 0.50)

# bedtools nuc provides the nucleotide content of intervals in .fa
# usage = bedtools nuc [OPTIONS] -fi <fasta> -bed <bed/gff/vcf>

# the first echo part creates a temporary bed file containing
# only the region of interest on chr22 using std bed format
# the -e arg is for printing escaped chars (vs literal text)
# ihavenoideawhatimdoing dog gif goes here

answer_2=$(echo -e "chr22\t19000000\t19000500" > tmp.bed \
        | bedtools nuc -fi $hg19fa -bed tmp.bed \
        | cut -f5 \
        | tail -n1 )

echo "answer-2: $answer_2"

# Question 3: Use bedtools to ID the length of the CTCF ChIP-seq
# peak (i.e., interval) that has the largest mean signal in 
# ctcf.hela.chr22.bg.gz.
# MAP
answer_3=$(bedtools map -a \
        <(gzcat $encode | awk '$4=="CTCF"') -b $bedgraph \
        -c 4 -o mean \
        | sort -k5 -nr \
        | head -n1 \
        | awk 'BEGIN{OFS="\t"} {print $3 -$2}')

echo "answer-3: $answer_3"

# Question 4: Use bedtools to ID the gene promotor (defined as:
# 1000 bp upstream of a TSS) w/ the highest median signal in
# ctcf.hela.chr22.bg.gz. Report the gene name (e.g., 'ABC123')
# FLANK
answer_4=$(bedtools flank -i $TSS -g $hg19gen -s -r 1000 -l 1000\
        | bedtools sort -i - \
        | bedtools map -a - -b $bedgraph -c 4 -o median \
        | awk '$7 != "."' \
        | sort -k7nr \
        | head -n1 \
        | cut -f4 )

echo "answer-4: $answer_4"

# Question 5: use bedtools to id the longest interval on chr22
# that is not covered by genes.hg19.bed. Report the interval
# like chr1: 100-500.
# COMPLEMENT
answer_5=$(bedtools complement -i $hg19bed -g $hg19gen \
        | sort -k4nr \
        | head -n1 \
        | awk '{print $1":"$2"-"$3}')

echo "answer-5: $answer_5"

# Question 6. Use 1 or more bedtools that we haven't covered
# in class. Be creative.
answer_6=

echo "answer-6: $answer_6"


