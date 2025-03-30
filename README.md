
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gtexr <a href="https://rmgpanw.github.io/gtexr/"><img src="man/figures/logo.png" align="right" height="138"/></a>

<!-- badges: start -->

[![pkgdown](https://github.com/rmgpanw/gtexr/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/rmgpanw/gtexr/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/rmgpanw/gtexr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/rmgpanw/gtexr?branch=main)
[![R-CMD-check](https://github.com/rmgpanw/gtexr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rmgpanw/gtexr/actions/workflows/R-CMD-check.yaml)
[![Deploy to
shinyapps.io](https://github.com/rmgpanw/gtexr/actions/workflows/shinyapps-deploy.yaml/badge.svg)](https://github.com/rmgpanw/gtexr/actions/workflows/shinyapps-deploy.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/gtexr)](https://CRAN.R-project.org/package=gtexr)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/gtexr)](https://CRAN.R-project.org/package=gtexr)
[![Repo
Status](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Status at rOpenSci Software Peer
Review](https://badges.ropensci.org/684_status.svg)](https://github.com/ropensci/software-review/issues/684)

<!-- badges: end -->

The goal of gtexr is to provide a convenient R interface to the [GTEx
Portal API
V2](https://gtexportal.org/api/v2/redoc#tag/GTEx-Portal-API-Info).

The [Genotype-Tissue Expression (GTEx)
project](https://www.gtexportal.org/home/) is a comprehensive public
resource for studying tissue-specific gene expression and regulation in
human tissues. Through systematic analysis of RNA sequencing data from
54 non-diseased tissue sites across nearly 1000 individuals, GTEx
provides crucial insights into the relationship between genetic
variation and gene expression. This data is accessible through the [GTEx
Portal
API](https://gtexportal.org/api/v2/redoc#tag/GTEx-Portal-API-Info),
enabling programmatic access to human gene expression data.

New to R but want to explore the available data? Try out the interactive
no-code ⭐[shiny app](https://7hocgq-rmgpanw.shinyapps.io/gtexr/)⭐.

## Installation

You can install this package from CRAN:

``` r
install.packages("gtexr")
```

Or you can install the development version of gtexr from
[GitHub](https://github.com/rmgpanw/gtexr) with:

``` r
# install.packages("pak")
pak::pak("rmgpanw/gtexr")
```

## Available functionality

- **GTEx Portal API Info** – Retrieve general service information about
  the GTEx API.  
- **Admin Endpoints** – Access maintenance messages and news updates
  from GTEx.  
- **Static Association Endpoints** – Query precomputed eQTL and sQTL
  associations across tissues.  
- **Dynamic Association Endpoints** – Perform on-the-fly eQTL and sQTL
  calculations.  
- **Biobank Data Endpoints** – Retrieve metadata on biobank samples.
- **Datasets Endpoints** – Access various GTEx dataset information, as
  well as variant annotation and linkage disequilibrium data.
- **Expression Data Endpoints** – Obtain expression levels across
  tissues, including gene, exon, junction, and transcript-level data.  
- **Histology Endpoints** – Retrieve tissue histology image data.  
- **Reference Genome Endpoints** – Query reference genome features,
  including genetic coordinates for genes, transcripts and exons, as
  well as reported phenotype associations for a region.

## Examples

Get general information about the GTEx service:

``` r
library(gtexr)
get_service_info()
#> # A tibble: 1 × 9
#>   id     name  version organization_name organization_url description contactUrl
#>   <chr>  <chr> <chr>   <chr>             <chr>            <chr>       <chr>     
#> 1 org.g… GTEx… 2.0.0   GTEx Project      https://gtexpor… This servi… https://g…
#> # ℹ 2 more variables: documentationUrl <chr>, environment <chr>
```

Retrieve eQTL genes for whole blood tissue:

``` r
get_eqtl_genes("Whole_Blood")
#> Warning: ! Total number of items (12360) exceeds maximum page size (250).
#> ℹ Try increasing `itemsPerPage`.
#> 
#> ── Paging info ─────────────────────────────────────────────────────────────────
#> • numberOfPages = 50
#> • page = 0
#> • maxItemsPerPage = 250
#> • totalNumberOfItems = 12360
#> # A tibble: 250 × 10
#>    tissueSiteDetailId ontologyId  datasetId empiricalPValue gencodeId geneSymbol
#>    <chr>              <chr>       <chr>               <dbl> <chr>     <chr>     
#>  1 Whole_Blood        UBERON:001… gtex_v8          1.05e- 9 ENSG0000… WASH7P    
#>  2 Whole_Blood        UBERON:001… gtex_v8          1.06e-25 ENSG0000… RP11-34P1…
#>  3 Whole_Blood        UBERON:001… gtex_v8          6.31e- 2 ENSG0000… CICP27    
#>  4 Whole_Blood        UBERON:001… gtex_v8          8.71e- 9 ENSG0000… RP11-34P1…
#>  5 Whole_Blood        UBERON:001… gtex_v8          6.01e-20 ENSG0000… RP11-34P1…
#>  6 Whole_Blood        UBERON:001… gtex_v8          6.96e- 9 ENSG0000… RP11-34P1…
#>  7 Whole_Blood        UBERON:001… gtex_v8          3.10e- 4 ENSG0000… RP11-34P1…
#>  8 Whole_Blood        UBERON:001… gtex_v8          1.92e- 3 ENSG0000… ABC7-4304…
#>  9 Whole_Blood        UBERON:001… gtex_v8          1.58e- 3 ENSG0000… RP11-34P1…
#> 10 Whole_Blood        UBERON:001… gtex_v8          7.82e- 2 ENSG0000… AP006222.2
#> # ℹ 240 more rows
#> # ℹ 4 more variables: log2AllelicFoldChange <dbl>, pValue <dbl>,
#> #   pValueThreshold <dbl>, qValue <dbl>
```

Retrieve significant eQTLs for one or more genes:

``` r
get_significant_single_tissue_eqtls(gencodeId = c(
  "ENSG00000132693.12",
  "ENSG00000203782.5"
))
#> 
#> ── Paging info ─────────────────────────────────────────────────────────────────
#> • numberOfPages = 1
#> • page = 0
#> • maxItemsPerPage = 250
#> • totalNumberOfItems = 249
#> # A tibble: 249 × 13
#>    snpId            pos snpIdUpper variantId  geneSymbol  pValue geneSymbolUpper
#>    <chr>          <int> <chr>      <chr>      <chr>        <dbl> <chr>          
#>  1 rs12128960 159343657 RS12128960 chr1_1593… CRP        8.52e-5 CRP            
#>  2 rs12132451 159344052 RS12132451 chr1_1593… CRP        7.92e-5 CRP            
#>  3 rs12136402 159347493 RS12136402 chr1_1593… CRP        7.92e-5 CRP            
#>  4 rs10908709 159350390 RS10908709 chr1_1593… CRP        7.92e-5 CRP            
#>  5 rs10908710 159351189 RS10908710 chr1_1593… CRP        7.92e-5 CRP            
#>  6 rs11265178 159359256 RS11265178 chr1_1593… CRP        9.62e-5 CRP            
#>  7 rs35532309 159360755 RS35532309 chr1_1593… CRP        6.11e-5 CRP            
#>  8 rs6692378  159369451 RS6692378  chr1_1593… CRP        1.17e-6 CRP            
#>  9 rs10908714 159370563 RS10908714 chr1_1593… CRP        1.80e-5 CRP            
#> 10 rs6656924  159372915 RS6656924  chr1_1593… CRP        1.00e-6 CRP            
#> # ℹ 239 more rows
#> # ℹ 6 more variables: datasetId <chr>, tissueSiteDetailId <chr>,
#> #   ontologyId <chr>, chromosome <chr>, gencodeId <chr>, nes <dbl>
```

## Community guidelines

Feedback, bug reports, and feature requests are welcome; file issues or
seek support [here](https://rmgpanw.github.io/gtexr/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://rmgpanw.github.io/gtexr/CONTRIBUTING.html).

Please note that the gtexr project is released with a [Contributor Code
of Conduct](https://rmgpanw.github.io/gtexr/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
