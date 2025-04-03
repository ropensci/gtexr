#' Get Multi Tissue Eqtls
#'
#' @description Find multi-tissue eQTL `Metasoft` results.
#'
#' - This service returns multi-tissue eQTL Metasoft results for a given gene and variant in a specified dataset.
#' - A Versioned GENCODE ID must be provided.
#' - For each tissue, the results include: m-value (mValue), normalized effect size (nes), p-value (pValue), and standard error (se).
#' - The m-value is the posterior probability that an eQTL effect exists in each tissue tested in the cross-tissue meta-analysis (Han and Eskin, PLoS Genetics 8(3): e1002555, 2012).
#' - The normalized effect size is the slope of the linear regression of normalized expression data versus the three genotype categories using single-tissue eQTL analysis, representing eQTL effect size.
#' - The p-value is from a t-test that compares observed NES from single-tissue eQTL analysis to a null NES of 0.
#'
#' By default, the service queries the latest GTEx release. The retrieved data is split into pages with `items_per_page` entries per page
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_multi_tissue_eqtls_api_v2_association_metasoft_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' # search by gene
#' get_multi_tissue_eqtls(gencodeId = "ENSG00000132693.12")
#'
#' # note that 'tissues' is a list-column
#' x <- get_multi_tissue_eqtls(gencodeId = "ENSG00000132693.12",
#'                             variantId = "chr1_159476920_T_C_b38")
#'
#' x$tissues[[1]]
#' }
get_multi_tissue_eqtls <- function(gencodeId,
                                   variantId = NULL,
                                   datasetId = "gtex_v8",
                                   page = 0,
                                   itemsPerPage = getOption("gtexr.itemsPerPage"),
                                   .verbose = getOption("gtexr.verbose"),
                                   .return_raw = FALSE) {
  gtex_query(endpoint = "association/metasoft", process_get_multi_tissue_eqtls_resp_json)
}

process_get_multi_tissue_eqtls_resp_json <- function(resp_json) {
  resp_json$data |>
    purrr::map(\(x) x |>
                 purrr::map_at("tissues", \(tissue) list(
                   purrr::map(tissue, tibble::as_tibble) |>
                     dplyr::bind_rows(.id = "tissue")
                 )) |>
                 tibble::as_tibble()) |>
    dplyr::bind_rows()
}
