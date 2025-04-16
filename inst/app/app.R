library(gtexr)
library(purrr)

check_packages <- function(pkgs, call = rlang::caller_env()) {
  missing_pkgs <- pkgs[!pkgs %in% installed.packages()[, "Package"]]

  if (length(missing_pkgs) > 0) {
    cli::cli_alert_warning("The following packages are missing: {.val {missing_pkgs}}")

    cli::cli_alert_info("Install them using:")
    cli::cli_text("{.code install.packages(c({paste0('\"', missing_pkgs, '\"', collapse = ', ')}))}")

    cli::cli_abort("Missing required packages.", call = call)
  }
}

check_packages(c("shiny", "stringr", "DT"), call = rlang::caller_env())

library(shiny)
library(stringr)
library(DT)

# Set up ------------------------------------------------------------------

gtexr_arguments_metadata <- gtexr:::gtexr_arguments()

# obtain and categorise list of gtexr functions programmatically
gtexr_docs <- rlang::new_environment()

lazyLoad(file.path(system.file("help", package = "gtexr"), "gtexr"),
         envir = gtexr_docs)

gtexr_docs <- as.list(gtexr_docs)

# function families
gtexr_functions_metadata <- gtexr_docs |>
  purrr::map(\(rd) rd |>
               purrr::keep(\(x) attr(x, which = "Rd_tag") == "\\concept")) |>
  purrr::compact() |>
  purrr::map_chr(\(x) x[[1]][[1]][1]) |>
  tibble::enframe(name = "fn_name",
                  value = "fn_family")

# function titles
gtexr_functions_metadata <- gtexr_docs |>
  purrr::map_chr(\(rd) rd[[1]][[1]][1]) |>
  tibble::enframe(name = "fn_name",
                  value = "fn_title") |>
  dplyr::full_join(gtexr_functions_metadata,
                   by = "fn_name")

# function docs, HTML
gtexr_functions_metadata <- gtexr_docs |>
  purrr::imap_chr(\(rd, fn) {
    .html <- paste0(fn, "_html")
    tools::Rd2HTML(rd, out = textConnection(.html, "w", local = TRUE))
    as.character(HTML(eval(as.symbol(.html))))
  }) |>
  tibble::enframe(name = "fn_name",
                  value = "fn_docs_html") |>
  dplyr::full_join(gtexr_functions_metadata,
                   by = "fn_name")

# function examples

# to see tags
# gtexr_docs$get_variant |>
#   purrr::map_chr(\(x) attr(x, which = "Rd_tag"))

gtexr_functions_metadata <- gtexr_docs |>
  purrr::map(\(rd) rd |>
               purrr::keep(\(x) attr(x, which = "Rd_tag") == "\\examples")) |>
  purrr::compact() |>
  purrr::map(\(x) {
    examples <- x[[1]] |>
      purrr::list_flatten() |>
      purrr::reduce(c) |>
      paste(sep = "", collapse = "") |>
      rlang::parse_exprs()

    examples[[1]]
  }) |>
  tibble::enframe(name = "fn_name",
                  value = "fn_example") |>
  dplyr::mutate("fn_example_args" = purrr::map(.data[["fn_example"]], \(first_example) {
    rlang::call_match(first_example,
                      eval(as.symbol(rlang::call_name(first_example))),
                      defaults = TRUE)[-1] |>
      as.list()
  })) |>
  dplyr::full_join(gtexr_functions_metadata,
                   by = "fn_name")

# get usage
gtexr_functions_metadata <- gtexr_docs |>
  purrr::map(\(rd) rd |>
               purrr::keep(\(x) attr(x, which = "Rd_tag") == "\\usage")) |>
  purrr::compact() |>
  purrr::map(\(x) x[[1]] |>
      purrr::list_flatten() |>
      purrr::reduce(c) |>
      paste(sep = "", collapse = "") |>
      rlang::parse_expr()) |>
  tibble::enframe(name = "fn_name",
                  value = "fn_usage") |>
  dplyr::mutate("fn_usage_args" = purrr::map(.data[["fn_usage"]], \(usage) {
    tryCatch(rlang::call_match(usage,
                      eval(as.symbol(rlang::call_name(usage))),
                      defaults = TRUE)[-1] |>
      as.list(),
      error = function(cnd) list())
  })) |>
  dplyr::full_join(gtexr_functions_metadata,
                   by = "fn_name")

# remove internal functions (gtexr_arguments())
gtexr_functions_metadata <- na.omit(gtexr_functions_metadata)

# Utils -------------------------------------------------------------------

get_gtexr_fn_args <- function(gtexr_fn) {
  gtexr_fn_args <- gtexr_fn |>
    rlang::sym() |>
    eval() |>
    rlang::fn_fmls()
}

detect_multiple_text_inputs <- function(gtexr_arguments_metadata,
                                        gtexr_fn_args) {
  gtexr_arguments_metadata |>
    dplyr::filter(.data[["arg"]] %in% !!names(gtexr_fn_args)) |>
    dplyr::filter(.data[["shinyinput"]] == "textAreaInput")
}

# UI ----------------------------------------------------------------------

endpointUI <- function(id, gtexr_fn, gtexr_arguments_metadata, gtexr_functions_metadata) {
  ns <- NS(id)

  gtexr_fn_args <- get_gtexr_fn_args(gtexr_fn)
  gtexr_fn_metadata <- gtexr_functions_metadata[gtexr_functions_metadata$fn_name == gtexr_fn, ]

  # if (gtexr_fn == "get_eqtl_genes") {
  #   browser()
  # }

  # create a list of UI inputs - one input for each function argument
  query_params <- gtexr_fn_args |>
    purrr::discard_at(c(".return_raw", ".verbose")) |>
    purrr::imap(\(default_value, arg) {
      arg_metadata <- gtexr_arguments_metadata[gtexr_arguments_metadata$arg == arg,]

      # include "" option if argument is optional
      if (!rlang::is_missing(default_value)) {
        if (is.null(default_value) &
            identical(arg_metadata$shinyinput, "selectInput")) {
          arg_metadata$shinyinput <- "selectizeInput"
        }
      }

      # set default values to first example from function documentation
      value <- eval(gtexr_fn_metadata$fn_example_args[[1]][[arg]])
      if (is.character(value) & arg_metadata$shinyinput != "selectizeInput") {
        value <- paste(value, sep = "", collapse = "\n")
      }

      switch(
        arg_metadata$shinyinput,
        "textInput" = rlang::call2(
          "textInput",
          inputId = rlang::call2("ns", arg),
          label = arg,
          value = value
        ),
        "textAreaInput" = rlang::call2(
          "textAreaInput",
          inputId = rlang::call2("ns", arg),
          label = arg,
          value = value
        ),
        "selectInput" = rlang::call2(
          "selectInput",
          inputId = rlang::call2("ns", arg),
          label = arg,
          choices = arg_metadata$choices[[1]],
          selected = value
        ),
        "selectizeInput" = rlang::call2(
          "selectizeInput",
          inputId = rlang::call2("ns", arg),
          label = arg,
          choices = arg_metadata$choices[[1]],
          selected = value,
          multiple = TRUE
        ),
        "numericInput" = rlang::call2(
          "numericInput",
          inputId = rlang::call2("ns", arg),
          label = arg,
          min = arg_metadata$choices[[1]][1],
          max = arg_metadata$choices[[1]][2],
          value = value
        ),
        "checkboxInput" = rlang::call2(
          "checkboxInput",
          inputId = rlang::call2("ns", arg),
          label = arg,
          value = value
        ),
        cli::cli_abort(
          c(
            "Unrecognised `shinyinput` value for {.fn {gtexr_fn}} arg `{arg}`: '{arg_metadata$shinyinput}'",
            "i" = "Check `gtexr_arguments()`"
          )
        )
      )
    }) |>
    purrr::map(rlang::eval_tidy, env = rlang::caller_env(n = 0))

  # multiple text input params - these inputs need converting to character vectors
  multiple_text_inputs <- detect_multiple_text_inputs(gtexr_arguments_metadata,
                                                      gtexr_fn_args)

  # Important - UI fails to render if this is a named list
  names(query_params) <- NULL

  # UI
  tagList(
    sidebarLayout(
      sidebarPanel(
        !!!query_params,
        actionButton(ns("send_request"), "Go", class = "btn-success"),
        verbatimTextOutput(ns("query_code")),
        width = 2
      ),
      mainPanel(
        tabsetPanel(tabPanel(title = "Result",
                             DT::DTOutput(ns("result"))),
                    tabPanel(title = "Help",
                             tags$a(href = stringr::str_glue("https://docs.ropensci.org/gtexr/reference/{gtexr_fn}.html"), "GTExR reference"),
                             HTML(gtexr_functions_metadata[gtexr_functions_metadata$fn_name == gtexr_fn, ]$fn_docs_html)),
                    type = "pills"),
        width = 7
      )
    )
  )
}

# Server ------------------------------------------------------------------

endpointServer <- function(id, gtexr_fn) {
  gtexr_fn_args <- get_gtexr_fn_args(gtexr_fn)

  moduleServer(id, function(input, output, session) {
    # generate code with user-specified argument values
    query <- eventReactive(input$send_request,
                           ignoreInit = TRUE,
                           valueExpr = {
                             # extract query params from user input
                             query_params_input <-
                               reactiveValuesToList(input)[names(gtexr_fn_args)]

                             # split any multiple text entries into character vectors
                             multiple_text_inputs <-
                               detect_multiple_text_inputs(gtexr_arguments_metadata,
                                                           gtexr_fn_args)

                             query_params_input <-
                               query_params_input |>
                               purrr::map_at(.at = multiple_text_inputs$arg,
                                             \(x) x |>
                                               stringr::str_split_1("\n") |>
                                               stringr::str_trim()) |>
                               purrr::compact()

                             # create call
                             rlang::call2(gtexr_fn,!!!query_params_input)
                           })

    # display generated code
    output$query_code <- renderPrint(query())

    # evaluate code, catching any error messages
    response <-
      reactive({
        id <-
          shiny::showNotification("Performing request...",
                                  duration = NULL,
                                  closeButton = FALSE,
                                  type = "message")
        on.exit(removeNotification(id), add = TRUE)

        withCallingHandlers(
        eval(query()),
        error = function(cnd)
          cnd,
        warning = function(cnd)
          shiny::showNotification(
            paste(cnd$message_unformatted, sep = "", collapse = "\n\n"),
            type = "warning",
            duration = 10
          )
      )})

    output$result <-
      DT::renderDT({
        if (inherits(response(), "error")) {
          shiny::validate(c(response()$message, response()$body))
        }

        if (nrow(response()) == 0) {
          shiny::validate("<< No results >>")
        }

        DT::datatable(response() |>
                        dplyr::mutate(dplyr::across(
                          dplyr::where(is.list),
                          \(x) "[[data]]"
                        )),
                      rownames = FALSE,
                      filter = "top")
      })
  })
}

# Single GTExR module app -------------------------------------------------

# For testing a single function

endpointMod <- function(gtexr_fn,
                        gtexr_arguments_metadata,
                        gtexr_functions_metadata) {
  ui <- fluidPage(endpointUI(
    id = gtexr_fn,
    gtexr_fn = gtexr_fn,
    gtexr_arguments_metadata = gtexr_arguments_metadata,
    gtexr_functions_metadata = gtexr_functions_metadata
  ))

  server <- function(input, output, session) {
    endpointServer(id = gtexr_fn,
                   gtexr_fn = gtexr_fn)
  }

  shinyApp(ui, server)
}

endpointMod("get_genes",
            gtexr_arguments_metadata = gtexr_arguments_metadata,
            gtexr_functions_metadata = gtexr_functions_metadata)

# App ---------------------------------------------------------------------

# create UI tabPanels programmatically

endpoint_tab_panels <- gtexr_functions_metadata$fn_family |>
  unique() |>
  sort() |>
  purrr::map(\(fn_family) tabPanel(fn_family,
                                tabsetPanel(!!!{
                                  gtexr_functions_metadata |>
                                    dplyr::filter(.data[["fn_family"]] == !!fn_family) |>
                                    dplyr::select(fn_name, fn_title) |>
                                    dplyr::arrange(fn_title) |>
                                    as.list() |>
                                    purrr::pmap(\(fn_name, fn_title) tabPanel(fn_title,
                                                              endpointUI(
                                                                fn_name,
                                                                gtexr_fn = fn_name,
                                                                gtexr_arguments_metadata = gtexr_arguments_metadata,
                                                                gtexr_functions_metadata = gtexr_functions_metadata
                                                              )))
                                })))

ui <-
  navbarPage(
    title = tags$a(href = "https://docs.ropensci.org/gtexr/", "GTExR", style = "text-decoration: none; color: black;"),
    !!!endpoint_tab_panels,
    theme = bslib::bs_theme(bootswatch = "lumen"),
    collapsible = TRUE,
    selected = "GTEx Portal API Info"
  )

# construct server function programmatically

server_body <- gtexr_functions_metadata$fn_name |>
  purrr::map(\(fn_name) rlang::call2("endpointServer", id = fn_name, gtexr_fn = fn_name))

server_body <- rlang::call2("{",!!!server_body)

server <-
  rlang::new_function(rlang::pairlist2(
    input = ,
    output = ,
    session =
  ),
  body = server_body)

shinyApp(ui, server)
