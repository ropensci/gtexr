#' Get Transcripts
#'
#' @description Find all transcripts of a reference gene.
#'
#' - This service returns information about transcripts of the given versioned GENCODE ID.
#' - A genome build and GENCODE version must be provided.
#' - By default, this service queries the genome build and GENCODE version used by the latest GTEx release.
#'
#' [GTEx API Portal
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_transcripts_api_v2_reference_transcript_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Reference Genome Endpoints
#'
#' @examples
#' \dontrun{
#' get_transcripts(gencodeId = "ENSG00000203782.5")
#' }
get_transcripts <- function(gencodeId,
                            gencodeVersion = "v26",
                            genomeBuild = "GRCh38/hg38",
                            page = 0,
                            itemsPerPage = getOption("gtexr.itemsPerPage"),
                            .verbose = getOption("gtexr.verbose"),
                            .return_raw = FALSE) {
  gtex_query(endpoint = "reference/transcript")
}
