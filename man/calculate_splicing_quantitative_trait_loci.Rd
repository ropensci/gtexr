% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_splicing_quantitative_trait_loci.R
\name{calculate_splicing_quantitative_trait_loci}
\alias{calculate_splicing_quantitative_trait_loci}
\title{Calculate Splicing Quantitative Trait Loci}
\usage{
calculate_splicing_quantitative_trait_loci(
  tissueSiteDetailId,
  phenotypeId,
  variantId,
  datasetId = "gtex_v8",
  .return_raw = FALSE
)
}
\arguments{
\item{tissueSiteDetailId}{String. The ID of the tissue of interest. Can be a
GTEx specific ID (e.g. "Whole_Blood"; use \code{\link[=get_tissue_site_detail]{get_tissue_site_detail()}}
to see valid values) or an Ontology ID.}

\item{phenotypeId}{String. See
\href{https://www.gtexportal.org/home/faq#splicingPhenotypeId}{GTEx portal FAQs}
for further details.}

\item{variantId}{String. A gtex variant ID.}

\item{datasetId}{String. Unique identifier of a dataset. Usually includes a
data source and data release. Options: "gtex_v8", "gtex_snrnaseq_pilot".}

\item{.return_raw}{Logical. If \code{TRUE}, return the raw API JSON response.
Default = \code{FALSE}}
}
\value{
A tibble. Or a list if \code{.return_raw = TRUE}.
}
\description{
\href{https://gtexportal.org/api/v2/redoc#tag/Dynamic-Association-Endpoints/operation/calculate_splicing_quantitative_trait_loci_api_v2_association_dynsqtl_get}{GTEx Portal API documentation}.
}
\examples{
\dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# perform request - returns a tibble with a single row
calculate_splicing_quantitative_trait_loci(
  tissueSiteDetailId = "Whole_Blood",
  phenotypeId = "chr1:15947:16607:clu_40980:ENSG00000227232.5",
  variantId = "chr1_14677_G_A_b38"
)
\dontshow{\}) # examplesIf}
}
\seealso{
Other Dynamic Association Endpoints: 
\code{\link{calculate_expression_quantitative_trait_loci}()},
\code{\link{calculate_ieqtls}()},
\code{\link{calculate_isqtls}()}
}
\concept{Dynamic Association Endpoints}
