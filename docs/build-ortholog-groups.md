# Build Ortholog Groups

<!-- MarkdownTOC -->

- [Gramene v46](#gramene-v46)
    - [Set Parameters](#set-parameters)
    - [Create Ortholog Groups](#create-ortholog-groups)
    - [Calculate Ortholog Group Membership Frequencies](#calculate-ortholog-group-membership-frequencies)
- [Gramene v49](#gramene-v49)
    - [Set Parameters](#set-parameters-1)
    - [Create Ortholog Groups](#create-ortholog-groups-1)
    - [Remove Putative Non-genes from Gene Lists](#remove-putative-non-genes-from-gene-lists)
    - [Calculate Ortholog Group Membership Frequencies](#calculate-ortholog-group-membership-frequencies-1)
    - [Build Ortholog Groups for Genes Without *A. thaliana* Orthologs](#build-ortholog-groups-for-genes-without-a-thaliana-orthologs)
        - [Identify *M. truncatula* Genes Without an *A. thaliana* Ortholog](#identify-m-truncatula-genes-without-an-a-thaliana-ortholog)
        - [Get orthologous relationships between *M. truncatula* and each of *O. sativa* and *S. lycopersicum*](#get-orthologous-relationships-between-m-truncatula-and-each-of-o-sativa-and-s-lycopersicum)
            - [Parameters](#parameters)
            - [Output](#output)
        - [Duplicate first column of *M. trunculata* orthologs](#duplicate-first-column-of-m-trunculata-orthologs)

<!-- /MarkdownTOC -->


## Gramene v46

### Set Parameters

```sh
BASE_DIR=~/git.repos/orthologs
BIN_DIR=$BASE_DIR/bin
DATA_DIR=$BASE_DIR/data/v46
RESULTS_DIR=$BASE_DIR/results/v46/2015-09-24/
SPECIES_LIST=(Mt Os Sl)

mkdir -p $RESULTS_DIR
```


### Create Ortholog Groups

```sh
cd $RESULTS_DIR
$BIN_DIR/create-orthologous-groups.pl \
  $DATA_DIR/gramene-orthologs.ids-only.txt At ${SPECIES_LIST[*]}
# Takes 10.5 minutes on my laptop
```


### Calculate Ortholog Group Membership Frequencies

```sh
for SPECIES in ${SPECIES_LIST[*]}; do
    echo $SPECIES:
    $BIN_DIR/ortholog-group-membership-freqs.pl $SPECIES $DATA_DIR $RESULTS_DIR
done
```


>     Mt:
    {
        0   28613,
        1   22809,
        2   95,
        3   2
    }
    Os:
    {
        0   20227,
        1   14574,
        2   2546,
        3   393,
        4   66,
        5   24
    }
    Sl:
    {
        0   14688,
        1   18890,
        2   427,
        3   14,
        4   4
    }


## Gramene v49

### Set Parameters

```sh
BASE_DIR=~/git.repos/orthologs
BIN_DIR=$BASE_DIR/bin
DATA_DIR=$BASE_DIR/data/v49
RESULTS_DIR=$BASE_DIR/results/v49
SPECIES_LIST=(Mt Os Sl)

mkdir -p $RESULTS_DIR
```


### Create Ortholog Groups

```sh
cd $RESULTS_DIR
$BIN_DIR/create-orthologous-groups.pl \
  $DATA_DIR/gramene-orthologs.ids-only.txt At ${SPECIES_LIST[*]}
# Takes 9.9 minutes on my laptop
```


### Remove Putative Non-genes from Gene Lists

The gene lists for contain some members that don't appear to be genes. They are prefixed with one of the following:

- `EPl` (I'm not sure what this is; however, I found a few potential links between Gramene, EPl, and phylogenetic trees.)
- `NCRNA` (non-coding RNA)
- `RRNA` (ribosomal RNA)

None of these show up in any of the ortholog groups. Therefore, I will remove these from the gene lists.

```sh
grep -c -e EPl -e NCRNA -e RRNA $DATA_DIR/*.all-genes.txt $RESULTS_DIR/groups.txt
```


>     /Users/mfc/git.repos/orthologs/data/v49/Mt.all-genes.txt:2554
    /Users/mfc/git.repos/orthologs/data/v49/Os.all-genes.txt:53250
    /Users/mfc/git.repos/orthologs/data/v49/Sl.all-genes.txt:3941
    /Users/mfc/git.repos/orthologs/results/v49/groups.txt:0


There are also IDs that might be *M truncatula* scaffolds (e.g., `MTR_0001s0010`). However, some of these show up in ortholog groups, so I'll leave them alone for now.

```sh
grep -c -e 'MTR_.*s' $DATA_DIR/Mt.all-genes.txt $RESULTS_DIR/groups.txt
```


>     /Users/mfc/git.repos/orthologs/data/v49/Mt.all-genes.txt:2602
    /Users/mfc/git.repos/orthologs/results/v49/groups.txt:417


Remove putative non-genes from gene lists:

```sh
for SPECIES in ${SPECIES_LIST[*]}; do
    mv $DATA_DIR/$SPECIES.all-genes.txt $DATA_DIR/$SPECIES.all-genes.original.txt
    grep -v -e EPl -e NCRNA -e RRNA $DATA_DIR/$SPECIES.all-genes.original.txt > $DATA_DIR/$SPECIES.all-genes.txt
done
```


### Calculate Ortholog Group Membership Frequencies

```sh
for SPECIES in ${SPECIES_LIST[*]}; do
    echo $SPECIES:
    $BIN_DIR/ortholog-group-membership-freqs.pl $SPECIES $DATA_DIR $RESULTS_DIR
done
```


>     Mt:
    {
        0   29754,
        1   21714,
        2   51
    }
    Os:
    {
        0   19932,
        1   14730,
        2   2591,
        3   430,
        4   74,
        5   38,
        6   35
    }
    Sl:
    {
        0   16425,
        1   17952,
        2   402,
        3   15
    }


### Build Ortholog Groups for Genes Without *A. thaliana* Orthologs

Plan:

- *M. truncatula*-based ortholog groups

    - Identify *M. truncatula* genes w/o an *A. thaliana* ortholog (i.e., not currently in an ortholog group)
    - Get orthologous relationships between *M. truncatula* and each of *O. sativa* and *S. lycopersicum*
    - Build ortholog groups for the subset of *M. truncatula* genes not belonging to an ortholog group

- *O. sativa*-based ortholog groups

    - Identify *O. sativa* genes w/o an *A. thaliana*/*M. truncatula* ortholog (i.e., not currently in an ortholog group)
    - Get orthologous relationships between *O. sativa* and *S. lycopersicum*
    - Build ortholog groups for the subset of *O. sativa* genes not belonging to an ortholog group


#### Identify *M. truncatula* Genes Without an *A. thaliana* Ortholog

```sh
SPECIES=Mt
comm -13 <(cut -f1 $RESULTS_DIR/$SPECIES.txt | sort -u) <(grep -v 'Gene stable ID' $DATA_DIR/$SPECIES.all-genes.txt | sort) > $SPECIES.no-ortholog.txt
```


#### Get orthologous relationships between *M. truncatula* and each of *O. sativa* and *S. lycopersicum*

##### Parameters

DATABASE: 'PLANT GENES 49'

DATASET: 'Medicago truncatula str. A17 genes (MedtrA17_4.0 (2014-06-EnsemblPlants))'

ATTRIBUTES:

- [x] Homologs
- Filters
  - [x] ID list limit
    - Gene Stable ID(s) using `Mt.no-ortholog.txt`
- Gene
  - Gene Attributes
    - [x] Gene stable ID
- Orthologs
  - Oryza sativa Japonica Orthologs
    - [x] Oryza sativa Japonica gene stable ID
    - [x] Oryza sativa Japonica % identity
  - Solanum lycopersicum str. Heinz 1706 Orthologs
    - [x] Solanum lycopersicum str. Heinz 1706 gene stable ID
    - [x] Solanum lycopersicum str. Heinz 1706 % identity

Count: `29754 / 54073 Genes`


##### Output

Output saved as tab-delimited file: `data/v49/mt-orthologs.txt`

Make version without '% identity' columns:

```sh
cut -f1,2,4 $DATA_DIR/Mt-orthologs.txt > $DATA_DIR/Mt-orthologs.ids-only.txt
```


#### Duplicate first column of *M. trunculata* orthologs

Need the *M. truncatula* ID column to be duplicated so that the ortholog group creation script will work properly. (Previously, the first column was *A. thaliana* IDs and was just used in the assembly and labeling of ortholog groups.)

```sh
perl -pi'.orig' -e '@cells = split /\t/; $_ = join "\t", $cells[0], @cells;' $DATA_DIR/Mt-orthologs.ids-only.txt
```
