# Build Ortholog Groups

<!-- MarkdownTOC -->

- [Gramene v46](#gramene-v46)
    - [Set Parameters](#set-parameters)
    - [Create Ortholog Groups](#create-ortholog-groups)
    - [Calculate Ortholog Group Membership Frequencies](#calculate-ortholog-group-membership-frequencies)

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
