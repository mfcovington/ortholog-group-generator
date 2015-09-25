#!/usr/bin/env perl
# Mike Covington
# created: 2015-09-24
#
# Description:
#
use strict;
use warnings;
use autodie;
use feature 'say';
use List::MoreUtils qw(uniq);


my ( $orthologs_file, $base_genotype, @ortho_genotypes ) = @ARGV;

my $orthologs
    = import_orthologs( $orthologs_file, $base_genotype, @ortho_genotypes );

exit;


sub import_orthologs {
    my ( $orthologs_file, $base_genotype, @ortho_genotypes ) = @_;

    my %orthologs;

    open my $orthologs_fh, "<", $orthologs_file;
    my $header = <$orthologs_fh>;
    while (<$orthologs_fh>) {
        chomp;
        my ( $base_gene, @ortho_genes ) = split /\t/;
        my %current_orthologs;
        @current_orthologs{@ortho_genotypes} = @ortho_genes;

        for my $genotype ( keys %current_orthologs ) {
            next unless $current_orthologs{$genotype};
            push @{ $orthologs{$base_gene}{$genotype} },
                $current_orthologs{$genotype};
            $orthologs{$base_gene}{$genotype}
                = [ uniq @{ $orthologs{$base_gene}{$genotype} } ];
        }
    }
    close $orthologs_fh;

    return \%orthologs;
}
