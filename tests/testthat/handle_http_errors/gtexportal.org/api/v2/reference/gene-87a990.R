structure(list(
  method = "GET", url = "https://gtexportal.org/api/v2/reference/gene?geneId=CRP&gencodeVersion=v26&genomeBuild=GRCh38%2Fhg38&page=-1&itemsPerPage=250",
  status_code = 422L, headers = structure(list(
    date = "Sun, 07 Apr 2024 20:35:08 GMT",
    `content-type` = "application/json", `content-length` = "152",
    server = "uvicorn", via = "1.1 google"
  ), class = "httr2_headers"),
  body = charToRaw("{\"detail\":[{\"loc\":[\"query\",\"page\"],\"msg\":\"ensure this value is greater than or equal to 0\",\"type\":\"value_error.number.not_ge\",\"ctx\":{\"limit_value\":0}}]}"),
  request = structure(list(
    url = "https://gtexportal.org/api/v2/reference/gene?geneId=CRP&gencodeVersion=v26&genomeBuild=GRCh38%2Fhg38&page=-1&itemsPerPage=250",
    method = NULL, headers = list(), body = NULL, fields = list(),
    options = list(useragent = "gtexr (https://github.com/ropensci/gtexr)"),
    policies = list(error_is_error = function(resp) {
      ifelse(!resp$status_code %in% c(200L, 422L, 400L), TRUE,
        FALSE
      )
    })
  ), class = "httr2_request"), cache = new.env(parent = emptyenv())
), class = "httr2_response")
