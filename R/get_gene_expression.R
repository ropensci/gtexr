#' Get Gene Expression
#'
#' @description Find normalized gene expression data.
#'
#' - Returns normalized gene expression in tissues at the sample level.
#' - Results may be filtered by dataset, gene or tissue, but at least one gene must be provided.
#'
#' By default, this service queries the latest GTEx release.
#'
#'  [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Expression-Data-Endpoints/operation/get_gene_expression_api_v2_expression_geneExpression_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Expression Data Endpoints
#'
#' @examples
#' \dontrun{
#' # multiple genes, selected tissues
#' get_gene_expression(
#'   gencodeIds = c(
#'     "ENSG00000132693.12",
#'     "ENSG00000203782.5"
#'   ),
#'   tissueSiteDetailIds = c("Thyroid", "Whole_Blood")
#' )
#'
#' # single gene, selected (single) tissue
#' get_gene_expression(
#'   gencodeIds = "ENSG00000132693.12",
#'   tissueSiteDetailIds = "Whole_Blood"
#' )
#'
#' # subset by sex
#' get_gene_expression(
#'   gencodeIds = "ENSG00000132693.12",
#'   tissueSiteDetailIds = "Whole_Blood",
#'   attributeSubset = "sex"
#' )
#'
#' # subset by age bracket
#' get_gene_expression(
#'   gencodeIds = "ENSG00000132693.12",
#'   tissueSiteDetailIds = "Whole_Blood",
#'   attributeSubset = "ageBracket"
#' )
#' }
get_gene_expression <- function(gencodeIds,
                                datasetId = "gtex_v8",
                                tissueSiteDetailIds = NULL,
                                attributeSubset = NULL,
                                page = 0,
                                itemsPerPage = getOption("gtexr.itemsPerPage"),
                                .verbose = getOption("gtexr.verbose"),
                                .return_raw = FALSE) {
  gtex_query(endpoint = "expression/geneExpression", process_get_gene_expression_resp_json)
}

process_get_gene_expression_resp_json <- function(resp_json) {
  resp_json$data |>
    purrr::map(\(x) {
      x$data <- list(as.numeric(x$data))
      x |>
        purrr::map_if(is.null, \(y) NA) |>
        tibble::as_tibble()
    }) |>
    dplyr::bind_rows()
}
