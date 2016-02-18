# Build Ortholog Groups

## Ortholog Groups for Gramene v46

```sh
BASE_DIR=~/git.repos/orthologs
RESULTS_DIR=$BASE_DIR/results/v46/2015-09-24/

mkdir -p $RESULTS_DIR
cd $RESULTS_DIR
$BASE_DIR/bin/create-orthologous-groups.pl \
  $BASE_DIR/data/gramene-orthologs.ids-only.txt At Mt Os Sl
# Takes 10.5 minutes on my laptop
```
