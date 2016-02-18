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
use JSON::XS;
use List::MoreUtils qw(uniq);


my ( $orthologs_file, $base_genotype, @ortho_genotypes ) = @ARGV;
my $id_file    = "ids.txt";
my $group_file = "groups.txt";

my $orthologs
    = import_orthologs( $orthologs_file, $base_genotype, @ortho_genotypes );

my $ortho_groups = consolidate_orthologous_groups($orthologs);
write_ortho_group_ids( $ortho_groups, $id_file );
write_ortho_groups( $ortho_groups, $group_file, \@ortho_genotypes );
write_ortho_groups_per_genotype( $ortho_groups, $group_file,
    \@ortho_genotypes );
exit;


sub consolidate_orthologous_groups {
    my $orthologs = shift;
    my %ortho_groups;
    my %paralogs;

    my %matched_genes;
    my $json = JSON::XS->new;
    $json->canonical(1);

    my $count = 0;

    my @base_gene_list = keys %{$orthologs};

    say scalar @base_gene_list;
    my $time = localtime;
    say "Started at $time";
    while ( my $gene_1 = shift @base_gene_list ) {
        next if exists $matched_genes{$gene_1};
        $paralogs{$gene_1} = [];

        for my $gene_2 (@base_gene_list) {
            next if exists $matched_genes{$gene_2};

            if ( $json->encode( $$orthologs{$gene_1} ) eq
                 $json->encode( $$orthologs{$gene_2} ) )
            {
                push @{ $paralogs{$gene_1} }, $gene_2;
                $matched_genes{$gene_2}++;
            }
        }
        $count++;
        if ( $count % 500 == 0 ) {
            $time = localtime;
            say "$count at $time";
        }
    }

    for my $gene ( keys %paralogs ) {
        my $like_genes = $paralogs{$gene};
        my $group_id = join "|", sort( $gene, @$like_genes );
        $ortho_groups{$group_id} = $$orthologs{$gene};
    }

    return \%ortho_groups;
}

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

sub write_ortho_groups {
    my ( $ortho_groups, $group_file, $ortho_genotypes ) = @_;

    open my $group_fh, ">", $group_file;
    for my $group_id ( sort keys %$ortho_groups ) {
        my @current_orthologs;
        for my $genotype (@ortho_genotypes) {
            if ( exists $$ortho_groups{$group_id}{$genotype} ) {
                push @current_orthologs,
                    @{ $$ortho_groups{$group_id}{$genotype} };
            }
        }
        say $group_fh join "\t", $group_id, sort @current_orthologs;
    }
    close $group_fh;
}

sub write_ortho_group_ids {
    my ( $ortho_groups, $id_file ) = @_;

    open my $id_fh, ">", $id_file;
    say $id_fh "$_" for sort keys %$ortho_groups;
    close $id_fh;
}

sub write_ortho_groups_per_genotype {
    my ( $ortho_groups, $ortho_genotypes ) = @_;

    for my $genotype (@ortho_genotypes) {
        open my $group_fh, ">", "$genotype.txt";
        for my $group_id ( sort keys %$ortho_groups ) {

            if ( exists $$ortho_groups{$group_id}{$genotype} ) {
                for my $gene ( @{ $$ortho_groups{$group_id}{$genotype} } ) {
                    say $group_fh join "\t", $gene, $group_id;
                }
            }
        }
        close $group_fh;
    }
}
