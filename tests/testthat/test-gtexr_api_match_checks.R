
get_gtex_openapi_json <- function() {
  httr2::request("https://gtexportal.org/api/v2/openapi.json") |>
    httr2::req_user_agent("gtexr (https://github.com/ropensci/gtexr)") |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

get_gtex_api_endpoints <- function(gtex_openapi_json) {
  result <- gtex_openapi_json$paths |>
    purrr::map(\(x) x$get) |>
    purrr::map(\(x) tibble::tibble(title = x$summary,
                                   category = x$tags[[1]],
                                   fn = x$summary |>
                                     tolower() |>
                                     stringr::str_replace_all(" ", "_"),
                                   params_raw = list(x$parameters))) |>
    dplyr::bind_rows(.id = "endpoint")

  # endpoints with non-unique names - join with category title
  duplicate_endpoint_names <- result |>
    dplyr::count(.data[["fn"]]) |>
    dplyr::arrange(dplyr::desc(.data[["n"]])) |>
    dplyr::filter(.data[["n"]] > 1) |>
    dplyr::pull(dplyr::all_of("fn"))

  result <- result |>
    dplyr::mutate(
      "fn" = dplyr::case_when(
        .data[["fn"]] %in% !!duplicate_endpoint_names ~ stringr::str_glue(
          "{fn}_{stringr::str_remove(tolower(stringr::str_replace_all(category, ' ', '_')), '_endpoints')}"
        ),
        TRUE ~ .data[["fn"]]
      )
    )

  # indicate whether returns paginated response
  result <- result |>
    dplyr::mutate(returns_paginated_response = purrr::map_lgl(params_raw, \(x) "itemsPerPage" %in% x$name))

  result <- result |>
    dplyr::mutate(params = purrr::map(
      .data[["params_raw"]],
      \(params_raw) purrr::map_df(
        params_raw,
        \(x) {
          result <- list(
            arg_raw = x$name,
            value = ifelse(x$required, list(NA), list(x$schema$default)),
            type = ifelse(is.null(x$schema$type), NA, x$schema$type),
            required = x$required
          )

          result$arg <- dplyr::case_when(
            result[["type"]] == "array" &
              result[["arg_raw"]] != "pathCategory" ~ paste0(result[["arg_raw"]], "s"),
            result[["arg_raw"]] == "featureId" ~ ".featureId",
            TRUE ~ result[["arg_raw"]]
          )

          result
        }
      )
    )) |>
    dplyr::mutate(param_names = purrr::map(params, \(x) suppressWarnings(x$arg)))

  return(result)
}

get_gtexr_fn_args <- function() {
  tibble::tibble(fn = getNamespaceExports("gtexr")) |>
    dplyr::mutate(args_all = purrr::map(
      .data[["fn"]],
      \(fn) fn |>
        get(envir = asNamespace("gtexr"), inherits = FALSE) |>
        rlang::fn_fmls() |>
        as.list() |>
        purrr::map_if(.p = rlang::is_missing, \(x) NA) |>
        purrr::map_at("itemsPerPage", \(x) 250) |>
        tibble::enframe(name = "arg", value = "value")
    )) |>
    dplyr::mutate("has_verbose_arg" = purrr::map_lgl(.data[["args_all"]], \(args) ".verbose" %in% args$arg)) |>
    dplyr::mutate("has_return_raw_arg" = purrr::map_lgl(.data[["args_all"]], \(args) ".return_raw" %in% args$arg)) |>
    dplyr::mutate("args" = purrr::map(.data[["args_all"]], \(args) args[!args$arg %in% c(".verbose", ".return_raw"), ])) |>
    dplyr::mutate("arg_names" = purrr::map(.data[["args"]], \(args) args$arg))
}

test_that("All checks comparing gtexr and GTEx API spec pass", {
  skip_if_offline()
  # Set up -------------------------------------------------------

  gtex_api_endpoints <- get_gtex_openapi_json() |>
    get_gtex_api_endpoints()

  gtexr_fn_args <- get_gtexr_fn_args()

  # Checks ------------------------------------------------------------------

  checks <- c()

  ## GTEx API endpoint coverage ----------------------------------------------

  # All API endpoints have a matching gtexr function

  missing_endpoints <- gtex_api_endpoints$fn[!gtex_api_endpoints$fn %in% gtexr_fn_args$fn]

  if (rlang::is_empty(missing_endpoints)) {
    checks <- c(checks,
                "v" = "All GTEx API endpoints have a corresponding gtexr function")
  } else {
    checks <- c(
      checks,
      "x" = cli::format_inline(
        "{length(missing_endpoints)} are missing a corresponding gtexr function: {paste(missing_endpoints, sep = '', collapse = ', ')}."
      )
    )
  }

  ## .return_raw arg ---------------------------------------------------------

  # All functions have .return_raw argument

  fn_without_return_raw_arg <- gtexr_fn_args |>
    dplyr::filter(!.data[["has_return_raw_arg"]]) |>
    dplyr::pull(dplyr::all_of(fn))

  if (rlang::is_empty(fn_without_return_raw_arg)) {
    checks <- c(checks,
                "v" = "All gtexr functions have a `.return_raw` argument.")
  } else {
    checks <- c(
      checks,
      "x" = cli::format_inline(
        "{length(fn_without_return_raw_arg)} gtexr functions do not have a `.return_raw` argument: {paste(fn_without_return_raw_arg, sep = '', collapse = ', ')}."
      )
    )
  }

  ## .verbose arg ------------------------------------------------------------

  # All functions returning a paginated response have a .verbose argument

  paginated_fn_without_verbose_arg <- gtexr_fn_args |>
    dplyr::inner_join(gtex_api_endpoints,
                      by = "fn") |>
    dplyr::filter(.data[["returns_paginated_response"]]) |>
    dplyr::filter(!.data[["has_verbose_arg"]]) |>
    dplyr::pull(dplyr::all_of(fn))

  if (rlang::is_empty(paginated_fn_without_verbose_arg)) {
    checks <- c(checks,
                "v" = "All gtexr functions returning paginated responses have a `.verbose` argument.")
  } else {
    checks <- c(
      checks,
      "x" = cli::format_inline(
        "{length(paginated_fn_without_verbose_arg)} gtexr functions returning paginated responses do not have a `.verbose` argument: {paste(paginated_fn_without_verbose_arg, sep = '', collapse = ', ')}."
      )
    )
  }

  ## Argument names ----------------------------------------------------------

  fn_with_unexpected_arg_names <- gtexr_fn_args |>
    dplyr::inner_join(gtex_api_endpoints,
                      by = "fn") |>
    dplyr::mutate(
      "param_names_string" = purrr::map_chr(.data[["param_names"]], \(param_names) paste(sort(param_names), sep = "", collapse = ", ")),
      "arg_names_string" = purrr::map_chr(.data[["arg_names"]], \(arg_names) paste(sort(arg_names), sep = "", collapse = ", "))
    ) |>
    dplyr::mutate("correct_arg_names" = purrr::map2(.x = param_names_string, .y = arg_names_string,
                                                    \(.x, .y) identical(sort(.x), sort(.y)))) |>
    tidyr::unnest(dplyr::all_of("correct_arg_names")) |>
    dplyr::filter(!.data[["correct_arg_names"]]) |>
    dplyr::pull(dplyr::all_of("fn"))

  if (rlang::is_empty(fn_with_unexpected_arg_names)) {
    checks <- c(checks,
                "v" = "All gtexr functions have expected argument names.")
  } else {
    checks <- c(
      checks,
      "x" = cli::format_inline(
        "{length(fn_with_unexpected_arg_names)} gtexr functions have unexpected argument names: {paste(fn_with_unexpected_arg_names, sep = '', collapse = ', ')}."
      )
    )
  }

  ## Argument values ---------------------------------------------------------

  fn_with_unexpected_default_arg_values <- list(
    gtexr = gtexr_fn_args |>
      dplyr::select(fn, args) |>
      tidyr::unnest(args) |>
      dplyr::select(fn, arg, value),
    api = gtex_api_endpoints |>
      dplyr::select(fn, params) |>
      tidyr::unnest(params) |>
      dplyr::select(fn, arg, value)
  ) |>
    purrr::reduce(dplyr::inner_join,
                  by = c("fn", "arg"),
                  suffix = c("_gtexr", "_api")) |>
    # use `==` instead of `identical()`, so that comparable numeric and integer
    # values pass (e.g. `1 == 1L` is ok to accept, but `identical(1, 1L)` will
    # return `FALSE`)
    dplyr::mutate(args_match = purrr::map2(.x = value_gtexr, .y = value_api, \(.x, .y) .x == .y)) |>
    tidyr::unnest(args_match) |>
    dplyr::filter(!args_match) |>
    dplyr::pull(fn) |>
    unique()

  if (rlang::is_empty(fn_with_unexpected_default_arg_values)) {
    checks <- c(checks,
                "v" = "All gtexr functions have expected default argument values.")
  } else {
    checks <- c(
      checks,
      "x" = cli::format_inline(
        "{length(fn_with_unexpected_default_arg_values)} gtexr functions have unexpected default argument values: {paste(fn_with_unexpected_default_arg_values, sep = '', collapse = ', ')}."
      )
    )
  }

  # Display messages ---------------------------------------------------------

  cli::cli_h1("gtexr-GTEx API checks")
  cli::cli_bullets(checks)

  n_failed_checks <- sum(names(checks) == "x")

  cli::cli_h2("Overall results")
  if (n_failed_checks > 0) {
    cli::cli_alert_danger("{n_failed_checks} failed checks")
  } else {
    cli::cli_alert_success("All gtexr-GTEx API checks passed")
  }

  expect_equal(n_failed_checks, 0L)
})
