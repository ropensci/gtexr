#' Get Maintenance Message
#'
#' @description Getting all the maintenance messages from the database that are
#'   enabled.
#'
#'   [GTEx Portal API
#'   documentation](https://gtexportal.org/api/v2/redoc#tag/Admin-Endpoints/operation/get_maintenance_message_api_v2_admin_maintenanceMessage_get).
#'
#' @details Note this typically returns an empty tibble.
#'
#' @inheritParams gtexr_arguments
#'
#' @return A tibble.
#' @export
#' @family Admin Endpoints
#'
#' @examples
#' \dontrun{
#' get_maintenance_message()
#' }
get_maintenance_message <- function(page = 0,
                                    itemsPerPage = 250,
                                    .return_raw = FALSE) {
  gtex_query(endpoint = "admin/maintenanceMessage")
}
