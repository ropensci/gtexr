# gtexr (development version)

## Major changes

* All functions now include a `.return_raw` argument, enabling the user to retrieve
the raw JSON from API calls.

* Functions that return a paginated response now include a `.verbose` argument,
which can be set to `FALSE` to suppress pagination messages. The `itemsPerPage`
argument for these functions can also be set globally by adjusting option
"gtexr.itemsPerPage".

## Minor changes and bug fixes

* Various function arguments have been updated to match the GTEx API:

  - `get_sqtl_genes()` argument `tissueSiteDetailId` has been pluralised to 
  `tissueSiteDetailIds`
  
  - `get_eqtl_genes()`, `get_sqtl_genes()` and `get_sample_datasets_endpoints()` 
  default argument values now match API

# gtexr 0.1.0

* Initial version accepted on CRAN.
