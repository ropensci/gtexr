# gtexr 0.2.0

## Major changes

* All functions now include a `.return_raw` argument, enabling the user to retrieve
the raw JSON from API calls.

* Functions that return a paginated response now include a `.verbose` argument,
which can be set to `FALSE` to suppress pagination messages. The `itemsPerPage`
argument for these functions can also be set globally by adjusting option
"gtexr.itemsPerPage".

* `get_dataset_info()` has now been fixed (previously returned an empty tibble).

* **Breaking changes:** 

  - `get_sample_datasets_endpoints()` has been renamed to
  `get_sample_datasets()`. This is to match the naming convention used for 
  `get_sample_biobank_data()`, whereby 'get_sample' is appended with 
  their respective category titles 'datasets' and 'biobank_data'.

  - `get_multi_tissue_eqtls()` has been fixed to return a tibble with one row 
  per data item. Argument `gencodeIds` has also been renamed to `gencodeId` to 
  match the GTEx API.

## Minor changes and bug fixes

* Various function arguments have been updated to match the GTEx API:

  - `get_sqtl_genes()` argument `tissueSiteDetailId` has been pluralised to 
  `tissueSiteDetailIds`.
  
  - `get_eqtl_genes()`, `get_sqtl_genes()`, `get_exons()`, `get_neighbor_gene()`, 
  `get_subject()`, `get_tissue_site_detail()`, `get_significant_single_tissue_sqtls()`, 
  `download()` and `get_sample_datasets()` (formerly called 
  `get_sample_datasets_endpoints()`) default argument values now match API.

# gtexr 0.1.0

* Initial version accepted on CRAN.
