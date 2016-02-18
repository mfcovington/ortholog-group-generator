# Download orthologous relationships from [Gramene](http://ensembl.gramene.org/biomart/martview)

## Gramene v46

### Parameters

DATABASE: 'PLANT GENES 46'

DATASET: 'Arabidopsis thaliana genes (TAIR10 (2010-09-TAIR10))'

ATTRIBUTES:

- (x) Homologs
- Gene
  - Gene Attributes
    - (x) Gene stable ID
- Orthologs
  - Medicago truncatula str. A17 Orthologs
    - (x) Medicago truncatula str. A17 gene stable ID
    - (x) Medicago truncatula str. A17 % identity
  - Oryza sativa Japonica Orthologs
    - (x) Oryza sativa Japonica gene stable ID
    - (x) Oryza sativa Japonica % identity
  - Solanum lycopersicum str. Heinz 1706 Orthologs
    - (x) Solanum lycopersicum str. Heinz 1706 gene stable ID
    - (x) Solanum lycopersicum str. Heinz 1706 % identity

### Output

Output saved as tab-delimited file: `data/v46/gramene-orthologs.txt`

Make version without '% identity' columns:

```sh
cut -f1,2,4,6 data/v46/gramene-orthologs.txt > data/v46/gramene-orthologs.ids-only.txt
```
