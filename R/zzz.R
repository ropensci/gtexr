.onLoad <- function(libname, pkgname) {

  all_pkg_opts <- list(
    gtexr.verbose = TRUE
  )

  current_options <- options()

  toset <- !(names(all_pkg_opts) %in% names(current_options))

  if(any(toset)) options(all_pkg_opts[toset])

  invisible()
}
