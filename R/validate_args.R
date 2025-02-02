validate_args <- function(arguments,
                          call) {
  metadata <- gtexr_arguments()

  empty_query_params <- arguments |>
    purrr::keep(rlang::is_missing)

  if (length(empty_query_params) > 0) {
    cli::cli_abort(
      c(
        "Identified {length(empty_query_params)} missing argument{?s} with no default value{?s} provided: ",
        "{paste(names(empty_query_params), sep = '', collapse = ', ')}"
      ),
      call = call
    )
  }

  # see ?purrr::purrr_error_indexed - withCallingHandlers() is used here to get
  # rid of purrr's wrapper error
  withCallingHandlers(
    purrr::iwalk(
      arguments,
      \(value, arg_name) {
        arg_metadata <- metadata[metadata$arg == arg_name, ]

        if (identical(nrow(arg_metadata), 0L)) {
          cli::cli_abort(
            c("Unrecognised argument: {.var {arg_name}}",
              "i" = "Please submit an issue at {.url {packageDescription('gtexr')$BugReports}} with a reproducible example.",
              "i" = "For gtexr package developers: check whether {.var {arg_name}} is included in {.fun gtexr_arguments}"
            ),
            call = call
          )
        }

        if (arg_metadata$scalar) {
          error_msg <-
            c("`{arg_name}` must be class {.cls {arg_metadata$type}} of length 1",
              "x" = "You supplied a {.cls {class(value)}} of length {length(value)}"
            )
        } else {
          error_msg <-
            c("`{arg_name}` must be class {.cls {arg_metadata$type}}",
              "x" = "You supplied class {.cls {class(value)}}"
            )
        }

        valid_type <- FALSE

        if (inherits(value, arg_metadata$type) |
          ((arg_metadata$type == "integer") &
            rlang::is_integerish(value))) {
          valid_type <- TRUE
        }

        if (!valid_type |
          (arg_metadata$scalar & length(value) > 1)) {
          cli::cli_abort(
            class = "gtexr_arg_class_or_length",
            message = error_msg,
            call = call
          )
        }
      }
    ),
    purrr_error_indexed = function(err) {
      rlang::cnd_signal(err$parent)
    }
  )

  # if checks pass, rename any pluralised args
  pluralised_args <- metadata[metadata$pluralised, ]$arg
  args_to_rename <- which(names(arguments) %in% pluralised_args)
  names(arguments)[args_to_rename] <-
    substr(names(arguments)[args_to_rename], 1, nchar(names(arguments)[args_to_rename]) - 1)

  return(arguments)
}
