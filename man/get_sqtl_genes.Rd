% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_sqtl_genes.R
\name{get_sqtl_genes}
\alias{get_sqtl_genes}
\title{Get Sqtl Genes}
\usage{
get_sqtl_genes(
  tissueSiteDetailIds = NULL,
  datasetId = "gtex_v8",
  page = 0,
  itemsPerPage = getOption("gtexr.itemsPerPage"),
  .verbose = getOption("gtexr.verbose"),
  .return_raw = FALSE
)
}
\arguments{
\item{tissueSiteDetailIds}{Character vector of IDs for tissues of interest.
Can be GTEx specific IDs (e.g. "Whole_Blood"; use
\code{\link[=get_tissue_site_detail]{get_tissue_site_detail()}} to see valid values) or Ontology IDs.}

\item{datasetId}{String. Unique identifier of a dataset. Usually includes a
data source and data release. Options: "gtex_v8", "gtex_snrnaseq_pilot".}

\item{page}{Integer (default = 0).}

\item{itemsPerPage}{Integer (default = 250). Set globally to maximum value
100000 with \code{options(list(gtexr.itemsPerPage = 100000))}.}

\item{.verbose}{Logical. If \code{TRUE} (default), print paging information. Set
to \code{FALSE} globally with \code{options(list(gtexr.verbose = FALSE))}.}

\item{.return_raw}{Logical. If \code{TRUE}, return the raw API JSON response.
Default = \code{FALSE}}
}
\value{
A tibble. Or a list if \code{.return_raw = TRUE}.
}
\description{
Retrieve sGenes (sQTL Genes).
\itemize{
\item This service returns sGenes (sQTL Genes) from the specified dataset.
\item Results may be filtered by tissue.
\item By default, the service queries the latest GTEx release.
}

The retrieved data is split into pages with \code{items_per_page} entries per page

\href{https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_sqtl_genes_api_v2_association_sgene_get}{GTEx Portal API documentation}.
}
\examples{
\dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
get_sqtl_genes("Whole_Blood")
\dontshow{\}) # examplesIf}
}
\seealso{
Other Static Association Endpoints: 
\code{\link{get_eqtl_genes}()},
\code{\link{get_fine_mapping}()},
\code{\link{get_independent_eqtl}()},
\code{\link{get_multi_tissue_eqtls}()},
\code{\link{get_significant_single_tissue_eqtls}()},
\code{\link{get_significant_single_tissue_eqtls_by_location}()},
\code{\link{get_significant_single_tissue_ieqtls}()},
\code{\link{get_significant_single_tissue_isqtls}()},
\code{\link{get_significant_single_tissue_sqtls}()}
}
\concept{Static Association Endpoints}
