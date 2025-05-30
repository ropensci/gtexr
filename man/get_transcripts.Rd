% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_transcripts.R
\name{get_transcripts}
\alias{get_transcripts}
\title{Get Transcripts}
\usage{
get_transcripts(
  gencodeId,
  gencodeVersion = "v26",
  genomeBuild = "GRCh38/hg38",
  page = 0,
  itemsPerPage = getOption("gtexr.itemsPerPage"),
  .verbose = getOption("gtexr.verbose"),
  .return_raw = FALSE
)
}
\arguments{
\item{gencodeId}{String. A Versioned GENCODE ID of a gene, e.g.
"ENSG00000065613.9".}

\item{gencodeVersion}{String (default = "v26"). GENCODE annotation release.
Either "v26" or "v19".}

\item{genomeBuild}{String. Options: "GRCh38/hg38", "GRCh37/hg19". Default =
"GRCh38/hg38".}

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
Find all transcripts of a reference gene.
\itemize{
\item This service returns information about transcripts of the given versioned GENCODE ID.
\item A genome build and GENCODE version must be provided.
\item By default, this service queries the genome build and GENCODE version used by the latest GTEx release.
}

\href{https://gtexportal.org/api/v2/redoc#tag/Reference-Genome-Endpoints/operation/get_transcripts_api_v2_reference_transcript_get}{GTEx API Portal documentation}
}
\examples{
\dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
get_transcripts(gencodeId = "ENSG00000203782.5")
\dontshow{\}) # examplesIf}
}
\seealso{
Other Reference Genome Endpoints: 
\code{\link{get_exons}()},
\code{\link{get_gene_search}()},
\code{\link{get_genes}()},
\code{\link{get_genomic_features}()},
\code{\link{get_gwas_catalog_by_location}()},
\code{\link{get_neighbor_gene}()}
}
\concept{Reference Genome Endpoints}
