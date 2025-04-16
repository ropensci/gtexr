gtex_query <- function(endpoint = NULL,
                       process_resp_fn = NULL) {
  # build request
  gtex_request <- httr2::request("https://gtexportal.org/api/v2/") |>
    httr2::req_user_agent("gtexr (https://github.com/ropensci/gtexr)")

  # append endpoint
  if (!is.null(endpoint)) {
    gtex_request <- gtex_request |>
      httr2::req_url_path_append(endpoint)
  }

  # append query parameters
  query_params <- NULL
  fn <- rlang::caller_fn()

  # process args
  if (!is.null(fn)) { # allows gtex_query() to be called directly
    caller_args <- rlang::fn_fmls_names(fn)

    return_raw <- tryCatch(rlang::env_get(env = rlang::caller_env(n = 1),
                                          nm = ".return_raw"),
                           error = function(cnd) {
                             cli::cli_abort(
                               c("Missing argument: {.var .return_raw}",
                                 "i" = "Please submit an issue at {.url {packageDescription('gtexr')$BugReports}} with a reproducible example.",
                                 "i" = "For gtexr package developers: check whether {.var .return_raw} is included in the calling function arguments."
                               ),
                               call = rlang::caller_env()
                             )
                           })

    validate_return_raw_arg(
      return_raw = return_raw,
      call = rlang::caller_env()
    )

    if (".verbose" %in% caller_args) {
      # determine verbosity
      verbose <- rlang::env_get(env = rlang::caller_env(n = 1),
                                         nm = ".verbose")

      validate_verbose_arg(verbose, call = rlang::caller_env())
    }

    # exclude arguments starting with "."
    query_params <- caller_args[!grepl("^\\.", caller_args)]
  }

  if (!rlang::is_empty(query_params)) {
    # create a named list of argument-value pairs
    query_params <- rlang::env_get_list(
      env = rlang::caller_env(n = 1),
      nms = query_params
    )

    query_params <- query_params |>
      purrr::map(process_na_and_zero_char_query_params) |>
      purrr::compact()

    query_params <- validate_args(
      arguments = query_params,
      call = rlang::caller_env()
    )

    # convert these to query parameters
    gtex_request <- gtex_request |>
      httr2::req_url_query(!!!query_params,
        .multi = "explode"
      )
  }

  gtex_resp_json <- perform_gtex_request_json(gtex_request, call = rlang::caller_env())

  # return early, if requested
  if (return_raw) {
    return(gtex_resp_json)
  }

  # If paging info, print
  if (!is.null(gtex_resp_json[["paging_info"]])) {

    paging_info_messages(gtex_resp_json, fn_name = as.character(rlang::caller_call()[[1]]), verbose)

    # convert response to a tibble
    if (!is.null(process_resp_fn)) {
      result <- process_resp_fn(gtex_resp_json)
    } else {
      result <- gtex_resp_json$data |>
        purrr::map(\(x) x |>
                     purrr::compact() |>
                     tibble::as_tibble()) |>
        dplyr::bind_rows()
    }

    if (nrow(result) != length(gtex_resp_json$data)) {
      cli::cli_abort(
        c(
          "Mismatch: processed GTEx API response has {nrow(result)} rows, but raw GTEx response has {length(gtex_resp_json$data)} elements.",
          "i" = "Please submit an issue at {.url {packageDescription('gtexr')$BugReports}} with a reproducible example."
        ),
        call = rlang::caller_env()
      )
    }

    # ...else if no paging info
  } else {
      result <- process_resp_fn(gtex_resp_json)
  }

  return(result)
}

perform_gtex_request_json <- function(gtex_request, call = rlang::caller_env()) {
  perform_gtex_request(gtex_request, call = call) |>
    httr2::resp_body_json() |>
    purrr::map(convert_null_to_na)
}

perform_gtex_request <- function(gtex_request, call) {
  gtex_response <- gtex_request |>
    httr2::req_error(is_error = \(resp) ifelse(!resp$status_code %in% c(200L, 422L, 400L, 404L),
      TRUE,
      FALSE
    )) |>
    httr2::req_perform()

  # handle http errors
  switch(as.character(gtex_response$status_code),
    "422" = gtex_response |>
      httr2::resp_body_json() |>
      handle_status_422(call = call),
    "400" = gtex_response |>
      httr2::resp_body_json() |>
      handle_status_400(call = call)
  )

  return(gtex_response)
}


convert_null_to_na <- function(x) {
  if (is.null(x)) {
    return(NA)
  } else {
    return(x)
  }
}

paging_info_messages <- function(gtex_resp_json,
                                 fn_name,
                                 verbose) {
  # warn user if not all available results fit on one page
  if ((gtex_resp_json$paging_info$totalNumberOfItems > gtex_resp_json$paging_info$maxItemsPerPage)) {

    n_items_exceeds_page_size_warning(fn_name,
                                      gtex_resp_json$paging_info$totalNumberOfItems,
                                      gtex_resp_json$paging_info$maxItemsPerPage)
  }

  # print paging info
  if (verbose) {
    cli::cli_h1("Paging info")
    gtex_resp_json$paging_info |>
      purrr::imap_chr(\(x, idx) paste(idx, x, sep = " = ")) |>
      purrr::set_names(nm = "*") |>
      cli::cli_bullets()
  }
}


process_na_and_zero_char_query_params <- function(x) {
  if (rlang::is_na(x) | identical(x, "")) {
    return(NULL)
  } else {
    return(x)
  }
}

validate_verbose_arg <- function(verbose,
                                 call) {
  if (!rlang::is_scalar_logical(verbose)) {
    cli::cli_abort(
      c(
        "!" = "Invalid `gtexr.verbose` option",
        "x" = cli::format_inline(
          "You supplied: {class(verbose)} of length {length(verbose)}"
        ),
        "i" = "`gtexr.verbose` must be either `TRUE` or `FALSE`",
        ">" = 'To see the current value, run `getOption("gtexr.verbose")`',
        ">" = 'Set verbosity on with `options(list(gtexr.verbose = TRUE))`',
        ">" = '...or off with `options(list(gtexr.verbose = FALSE))`'
      ),
      call = call
    )
  }
}

validate_return_raw_arg <- function(return_raw,
                                 call) {
  if (!rlang::is_scalar_logical(return_raw)) {
    cli::cli_abort(
      c(
        "!" = "Invalid `.return_raw` value",
        "x" = cli::format_inline(
          "You supplied: {class(return_raw)} of length {length(return_raw)}"
        ),
        "i" = "`return_raw` must be either `TRUE` or `FALSE`"
      ),
      call = call
    )
  }
}
