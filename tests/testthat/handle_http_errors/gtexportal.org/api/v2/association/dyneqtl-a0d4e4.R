structure(list(
  method = "GET", url = "https://gtexportal.org/api/v2/association/dyneqtl?tissueSiteDetailId=Whole_Blood&gencodeId=ENSG00000203782.5&variantId=invalid%20rsid&datasetId=gtex_v8",
  status_code = 400L, headers = structure(list(
    date = "Sun, 07 Apr 2024 20:35:08 GMT",
    `content-type` = "application/json", `content-length` = "68",
    server = "uvicorn", via = "1.1 google"
  ), class = "httr2_headers"),
  body = charToRaw("{\"detail\":\"variantId 'invalid rsid' not found in dataset 'gtex_v8'\"}"),
  request = structure(list(
    url = "https://gtexportal.org/api/v2/association/dyneqtl?tissueSiteDetailId=Whole_Blood&gencodeId=ENSG00000203782.5&variantId=invalid%20rsid&datasetId=gtex_v8",
    method = NULL, headers = list(), body = NULL, fields = list(),
    options = list(useragent = "gtexr (https://github.com/ropensci/gtexr)"),
    policies = list(error_is_error = function(resp) {
      ifelse(!resp$status_code %in% c(200L, 422L, 400L), TRUE,
        FALSE
      )
    })
  ), class = "httr2_request"), cache = new.env(parent = emptyenv())
), class = "httr2_response")
