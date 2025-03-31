#' Get Eqtl Genes
#'
#' @description Retrieve eGenes (eQTL Genes).
#'
#' - This service returns eGenes (eQTL Genes) from the specified dataset.
#' - eGenes are genes that have at least one significant cis-eQTL acting upon them.
#' - Results may be filtered by tissue. By default, the service queries the latest GTEx release.
#'
#' For each eGene, the results include the allelic fold change
#'   (log2AllelicFoldChange), p-value (pValue), p-value threshold
#'   (pValueThreshold), empirical p-value (empiricalPValue), and q-value
#'   (qValue).
#'
#' - The log2AllelicFoldChange is the allelic fold change (in log2 scale) of the most significant eQTL.
#' - The pValue is the nominal p-value of the most significant eQTL.
#' - The pValueThreshold is the p-value threshold used to determine whether a cis-eQTL for this gene is significant. For more details see https://gtexportal.org/home/documentationPage#staticTextAnalysisMethods.
#' - The empiricalPValue is the beta distribution-adjusted empirical p-value from FastQTL.
#' - The qValues were calculated based on the empirical p-values. A false discovery rate (FDR) threshold of <= 0.05 was applied to identify genes with a significant eQTL.
#'
#' [GTEx Portal API documentation](https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_eqtl_genes_api_v2_association_egene_get).
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Static Association Endpoints
#'
#' @examples
#' \dontrun{
#' get_eqtl_genes(c("Whole_Blood", "Artery_Aorta"))
#' }
get_eqtl_genes <- function(tissueSiteDetailIds = NULL,
                           datasetId = "gtex_v8",
                           page = 0,
                           itemsPerPage = getOption("gtexr.itemsPerPage"),
                           .verbose = getOption("gtexr.verbose"),
                           .return_raw = FALSE) {
  gtex_query(endpoint = "association/egene")
}
