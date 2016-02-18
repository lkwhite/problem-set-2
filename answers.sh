#! /usr/bin/env bash

datasets='/Users/lkw/2016-GA-Workshop/data-sets/'

hg19fa="$datasets/fasta/chr1.hg19.fa"
H3K4me3="$datasets/bed/encode.h3k4me3.hela.chr22.bed.gz"
hg19bed="$datasets/bed/genes.hg19.bed.gz"
encode="$datasets/bed/encode.tfbs.chr22.bed.gz"
bedgraph="$datasets/bedgraph/ctcf.hela.chr22.bg.gz"
hg19gen="$datasets/genome/hg19.genome"
TSS="$datasets/bed/tss.hg19.chr22.bed.gz"

# Question 1: Use bedtools intersect to ID size of
# largest overlap between CTCF and H3K4me locations


# Question 2: Use bedtools to calc the GC content of
# nucleotides 19,000,000 to 19,000,500 on chr22 of hg19
# genome build. Report the GC content as a fraction (e.g. 0.50)


# Question 3: Use bedtools to ID the length of the CTCF ChIP-seq
# peak (i.e., interval) that has the largest mean signal in 
# ctcf.hela.chr22.bg.gz.


# Question 4: Use bedtools to ID the gene promotor (defined as:
# 1000 bp upstream of a TSS) w/ the highest median signal in
# ctcf.hela.chr22.bg.gz. Report the gene name (e.g., 'ABC123')


# Question 5: use bedtools to id the longest interval on chr22
# that is not covered by genes.hg19.bed. Report the interval
# like chr1: 100-500.

# Question 6. Use 1 or more bedtools that we haven't covered
# in class. Be creative.
