process_resp_body_linkage_disequilibrium <- function(resp_body) {
  paging_info_messages(resp_body)

  if (rlang::is_empty(resp_body$data)) {
    return(tibble::tibble())
  }

  resp_body$data |>
    purrr::map(\(x) tibble::tibble(variants = x[[1]], ld = x[[2]])) |>
    dplyr::bind_rows() |>
    tidyr::separate_wider_delim(
      cols = "variants",
      delim = ",",
      names = c("variantId_1", "variantId_2")
    ) |>
    dplyr::mutate("ld" = as.numeric(.data[["ld"]]))
}

process_resp_body_clustered_expression <- function(resp_body, expression_item_name) {
  if (!expression_item_name %in% names(resp_body)) {
    cli::cli_abort(
      c(
        "Internal gtexr error - incorrect `expression_item_name`: '{expression_item_name}'",
        "i" = "Please submit an issue at {.url {packageDescription('gtexr')$BugReports}} with a reproducible example."
      )
    )
  }

  result <-
    resp_body[[expression_item_name]] |>
    purrr::map(tibble::as_tibble) |>
    dplyr::bind_rows()

  attr(result, "clusters") <- resp_body$clusters

  cli::cli_alert_info("Retrieve clustering data with `attr(<df>, 'clusters')`")

  return(result)
}
