#' Get Variant By Location
#'
#' @description This service allows the user to query information about variants
#'   on a certain chromosome at a certain location.
#'
#'   [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_variant_by_location_api_v2_dataset_variantByLocation_get)
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble.
#' @export
#' @family Datasets Endpoints
#'
#' @examples
#' get_variant_by_location(
#'   start = 153209600,
#'   end = 153209700,
#'   chromosome = "chr1"
#' )
get_variant_by_location <- function(start,
                                    end,
                                    chromosome,
                                    sortBy = "pos",
                                    sortDirection = "asc",
                                    page = 0,
                                    itemsPerPage = 250,
                                    .verbose = getOption("gtexr.verbose"),
                                    .return_raw = FALSE) {
  gtex_query(endpoint = "dataset/variantByLocation")
}
