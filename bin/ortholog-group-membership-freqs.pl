#!/usr/bin/env perl
# Mike Covington
# created: 2015-09-25
#
# Description:
#
use strict;
use warnings;
use autodie;
use feature 'say';
use Data::Printer;


my ( $species, $data_dir, $results_dir ) = @ARGV;
my %counts;

my $all_genes_file = "$data_dir/$species.all-genes.txt";
my $ortho_file = "$results_dir/$species.txt";

open my $all_genes_fh, "<", $all_genes_file;
while ( my $gene = <$all_genes_fh> ) {
    chomp $gene;
    $counts{$gene} = 0;
}
close $all_genes_fh;

open my $ortho_fh, "<", $ortho_file;
while (<$ortho_fh>) {
    chomp;
    my ( $gene, $group ) = split;
    $counts{$gene}++;
}
close $ortho_fh;

my %histogram;
for my $gene ( keys %counts ) {
    $histogram{$counts{$gene}}++;
}

p %histogram;
