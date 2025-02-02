handle_status_422 <- function(resp_body, call) {
  invalid_args <- resp_body$detail |>
    purrr::map_chr(\(x) cli::format_inline("`{x$loc[[2]]}`")) |>
    unique()
  n_invalid_args <- length(invalid_args)
  invalid_args <-
    cli::format_inline("Detected {{n_invalid_args}} invalid argument{{?s}}: {invalid_args}")
  names(invalid_args) <- "x"

  msgs <- resp_body$detail |>
    purrr::map_chr(\(x) cli::format_inline("`{x$loc[[2]]}`: {x$msg}"))
  names(msgs) <- rep("i", length(msgs))

  cli::cli_abort(
    class = "httr2_http_422",
    message = c(
      "!" = "HTTP 422 Validation Error",
      invalid_args,
      msgs
    ),
    call = call
  )
}

handle_status_400 <- function(resp_body, call) {
  cli::cli_abort(
    class = "httr2_http_400",
    message = c(
      "!" = "HTTP 400 Illegal Query Input",
      "x" = resp_body$detail
    ),
    call = call
  )
}
