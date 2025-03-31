#' Get News Item
#'
#' @description Getting all the news items from the database that are current.
#'
#' [GTEx Portal API
#' documentation](https://gtexportal.org/api/v2/redoc#tag/Admin-Endpoints/operation/get_news_item_api_v2_admin_newsItem_get).
#'
#' @inheritParams gtexr_arguments
#'
#' @returns A tibble. Or a list if `.return_raw = TRUE`.
#' @export
#' @family Admin Endpoints
#'
#' @examples
#' \dontrun{
#' get_news_item()
#' }
get_news_item <- function(page = 0,
                          itemsPerPage = getOption("gtexr.itemsPerPage"),
                          .verbose = getOption("gtexr.verbose"),
                          .return_raw = FALSE) {
  gtex_query(endpoint = "admin/newsItem")
}
