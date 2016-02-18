# Download Orthologous Relationships and Gene Lists from [Gramene](http://ensembl.gramene.org/biomart/martview)

<!-- MarkdownTOC -->

- [Gramene v46](#gramene-v46)
  - [Get Orthologous Relationships between *A. thaliana* and each of *M. truncatula*, *O. sativa*, and *S. lycopersicum*](#get-orthologous-relationships-between-a-thaliana-and-each-of-m-truncatula-o-sativa-and-s-lycopersicum)
    - [Parameters](#parameters)
    - [Output](#output)
  - [Get Gene Lists for *M. truncatula*, *O. sativa*, and *S. lycopersicum*](#get-gene-lists-for-m-truncatula-o-sativa-and-s-lycopersicum)
    - [Parameters](#parameters-1)
    - [Output](#output-1)
- [Gramene v49](#gramene-v49)
  - [Get Orthologous Relationships between *A. thaliana* and each of *M. truncatula*, *O. sativa*, and *S. lycopersicum*](#get-orthologous-relationships-between-a-thaliana-and-each-of-m-truncatula-o-sativa-and-s-lycopersicum-1)
    - [Parameters](#parameters-2)
    - [Output](#output-2)
  - [Get Gene Lists for *M. truncatula*, *O. sativa*, and *S. lycopersicum*](#get-gene-lists-for-m-truncatula-o-sativa-and-s-lycopersicum-1)
    - [Parameters](#parameters-3)
    - [Output](#output-3)

<!-- /MarkdownTOC -->


## Gramene v46

### Get Orthologous Relationships between *A. thaliana* and each of *M. truncatula*, *O. sativa*, and *S. lycopersicum*

#### Parameters

DATABASE: 'PLANT GENES 46'

DATASET: 'Arabidopsis thaliana genes (TAIR10 (2010-09-TAIR10))'

ATTRIBUTES:

- [x] Homologs
- Gene
  - Gene Attributes
    - [x] Gene stable ID
- Orthologs
  - Medicago truncatula str. A17 Orthologs
    - [x] Medicago truncatula str. A17 gene stable ID
    - [x] Medicago truncatula str. A17 % identity
  - Oryza sativa Japonica Orthologs
    - [x] Oryza sativa Japonica gene stable ID
    - [x] Oryza sativa Japonica % identity
  - Solanum lycopersicum str. Heinz 1706 Orthologs
    - [x] Solanum lycopersicum str. Heinz 1706 gene stable ID
    - [x] Solanum lycopersicum str. Heinz 1706 % identity


#### Output

Output saved as tab-delimited file: `data/v46/gramene-orthologs.txt`

Make version without '% identity' columns:

```sh
cut -f1,2,4,6 data/v46/gramene-orthologs.txt > data/v46/gramene-orthologs.ids-only.txt
```


### Get Gene Lists for *M. truncatula*, *O. sativa*, and *S. lycopersicum*

#### Parameters

DATABASE: 'PLANT GENES 46'

DATASETS:

- 'Medicago truncatula str. A17 genes (MedtrA17_4.0 (2014-06-EnsemblPlants))'
- 'Oryza sativa Japonica genes (IRGSP-1.0 (IRGSP-1.0))'
- 'Solanum lycopersicum str. Heinz 1706 genes (SL2.50 (2014-10-EnsemblPlants))'

ATTRIBUTES:

- [x] Features
- Gene
  - Gene Attributes
    - [x] Gene stable ID


#### Output

Outputs saved as tab-delimited files:

- `data/v46/Mt.all-genes.txt`
- `data/v46/Os.all-genes.txt`
- `data/v46/Sl.all-genes.txt`


## Gramene v49

### Get Orthologous Relationships between *A. thaliana* and each of *M. truncatula*, *O. sativa*, and *S. lycopersicum*

#### Parameters

DATABASE: 'PLANT GENES 49'

DATASET: 'Arabidopsis thaliana genes (TAIR10 (2010-09-TAIR10))'

ATTRIBUTES:

- [x] Homologs
- Gene
  - Gene Attributes
    - [x] Gene stable ID
- Orthologs
  - Medicago truncatula str. A17 Orthologs
    - [x] Medicago truncatula str. A17 gene stable ID
    - [x] Medicago truncatula str. A17 % identity
  - Oryza sativa Japonica Orthologs
    - [x] Oryza sativa Japonica gene stable ID
    - [x] Oryza sativa Japonica % identity
  - Solanum lycopersicum str. Heinz 1706 Orthologs
    - [x] Solanum lycopersicum str. Heinz 1706 gene stable ID
    - [x] Solanum lycopersicum str. Heinz 1706 % identity


#### Output

Output saved as tab-delimited file: `data/v49/gramene-orthologs.txt`

Make version without '% identity' columns:

```sh
cut -f1,2,4,6 data/v49/gramene-orthologs.txt > data/v49/gramene-orthologs.ids-only.txt
```


### Get Gene Lists for *M. truncatula*, *O. sativa*, and *S. lycopersicum*

#### Parameters

DATABASE: 'PLANT GENES 49'

DATASETS:

- 'Medicago truncatula str. A17 genes (MedtrA17_4.0 (2014-06-EnsemblPlants))'
- 'Oryza sativa Japonica genes (IRGSP-1.0 (IRGSP-1.0))'
- 'Solanum lycopersicum str. Heinz 1706 genes (SL2.50 (2014-10-EnsemblPlants))'

ATTRIBUTES:

- [x] Features
- Gene
  - Gene Attributes
    - [x] Gene stable ID


#### Output

Outputs saved as tab-delimited files:

- `data/v49/Mt.all-genes.txt`: 54073 / 54073 Genes
- `data/v49/Os.all-genes.txt`: 91080 / 91080 Genes
- `data/v49/Sl.all-genes.txt`: 38735 / 38735 Genes
