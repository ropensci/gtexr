% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_fine_mapping.R
\name{get_fine_mapping}
\alias{get_fine_mapping}
\title{Get Fine Mapping}
\usage{
get_fine_mapping(
  gencodeIds,
  datasetId = "gtex_v8",
  variantId = NULL,
  tissueSiteDetailIds = NULL,
  page = 0,
  itemsPerPage = getOption("gtexr.itemsPerPage"),
  .verbose = getOption("gtexr.verbose"),
  .return_raw = FALSE
)
}
\arguments{
\item{gencodeIds}{A character vector of Versioned GENCODE IDs, e.g.
c("ENSG00000132693.12", "ENSG00000203782.5").}

\item{datasetId}{String. Unique identifier of a dataset. Usually includes a
data source and data release. Options: "gtex_v8", "gtex_snrnaseq_pilot".}

\item{variantId}{String. A gtex variant ID.}

\item{tissueSiteDetailIds}{Character vector of IDs for tissues of interest.
Can be GTEx specific IDs (e.g. "Whole_Blood"; use
\code{\link[=get_tissue_site_detail]{get_tissue_site_detail()}} to see valid values) or Ontology IDs.}

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
Retrieve Fine Mapping Data
\itemize{
\item Finds and returns \verb{Fine Mapping} data for the provided list of genes
\item By default, this endpoint fetches data from the latest \code{GTEx} version
}

The retrieved data is split into pages with \code{items_per_page} entries per page

\href{https://gtexportal.org/api/v2/redoc#tag/Static-Association-Endpoints/operation/get_fine_mapping_api_v2_association_fineMapping_get}{GTEx Portal API documentation}
}
\examples{
\dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# search by gene
get_fine_mapping(gencodeIds = c(
  "ENSG00000132693.12",
  "ENSG00000203782.5"
))

# optionally filter for a single variant and/or one or more tissues
get_fine_mapping(
  gencodeIds = c(
    "ENSG00000132693.12",
    "ENSG00000203782.5"
  ),
  variantId = "chr1_153228363_A_G_b38",
  tissueSiteDetailIds = c(
    "Whole_Blood",
    "Thyroid"
  )
)
\dontshow{\}) # examplesIf}
}
\seealso{
Other Static Association Endpoints: 
\code{\link{get_eqtl_genes}()},
\code{\link{get_independent_eqtl}()},
\code{\link{get_multi_tissue_eqtls}()},
\code{\link{get_significant_single_tissue_eqtls}()},
\code{\link{get_significant_single_tissue_eqtls_by_location}()},
\code{\link{get_significant_single_tissue_ieqtls}()},
\code{\link{get_significant_single_tissue_isqtls}()},
\code{\link{get_significant_single_tissue_sqtls}()},
\code{\link{get_sqtl_genes}()}
}
\concept{Static Association Endpoints}
