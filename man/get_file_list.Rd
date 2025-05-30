% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_file_list.R
\name{get_file_list}
\alias{get_file_list}
\title{Get File List}
\usage{
get_file_list(.return_raw = FALSE)
}
\arguments{
\item{.return_raw}{Logical. If \code{TRUE}, return the raw API JSON response.
Default = \code{FALSE}}
}
\value{
A tibble. Or a list if \code{.return_raw = TRUE}.
}
\description{
Get all the files in GTEx dataset for Download page

\href{https://gtexportal.org/api/v2/redoc#tag/Datasets-Endpoints/operation/get_file_list_api_v2_dataset_fileList_get}{GTEx Portal API documentation}
}
\details{
The returned tibble includes a nested list column, "filesets". This
details files, sub-categorised by fileset (see examples section).
}
\examples{
\dontshow{if (identical(Sys.getenv("IN_PKGDOWN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# Column "filesets" is a list column
get_file_list()

# Get "GTEx Analysis V9" file list
gtex_v9_files <- get_file_list() |>
  dplyr::filter(name == "GTEx Analysis V9") |>
  dplyr::pull(filesets)

# "GTEx Analysis V9" filesets
names(gtex_v9_files[[1]])

# "GTEx Analysis V9", "snRNA-Seq Data" fileset files
names(gtex_v9_files[[1]][["snRNA-Seq Data"]]$files)
\dontshow{\}) # examplesIf}
}
\seealso{
Other Datasets Endpoints: 
\code{\link{get_annotation}()},
\code{\link{get_collapsed_gene_model_exon}()},
\code{\link{get_downloads_page_data}()},
\code{\link{get_full_get_collapsed_gene_model_exon}()},
\code{\link{get_functional_annotation}()},
\code{\link{get_linkage_disequilibrium_by_variant_data}()},
\code{\link{get_linkage_disequilibrium_data}()},
\code{\link{get_sample_datasets}()},
\code{\link{get_subject}()},
\code{\link{get_tissue_site_detail}()},
\code{\link{get_variant}()},
\code{\link{get_variant_by_location}()}
}
\concept{Datasets Endpoints}
