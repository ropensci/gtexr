with_mock_dir("handle_http_errors", {
  test_that("httr2_http_400 error condition is raised", {
    expect_error(
      calculate_expression_quantitative_trait_loci(
        tissueSiteDetailId = "Whole_Blood",
        gencodeId = "ENSG00000203782.5",
        variantId = "invalid rsid"
      ),
      class = "httr2_http_400"
    )

    expect_error(
      calculate_expression_quantitative_trait_loci(
        tissueSiteDetailId = "Whole_Blood",
        gencodeId = "ENSG00000203782.5",
        variantId = "invalid rsid"
      ),
      regexp = "variantId 'invalid rsid' not found in dataset 'gtex_v8'"
    )
  })

  test_that("httr2_http_422 error condition is raised", {
    expect_error(get_genes("CRP", page = -1),
      class = "httr2_http_422"
    )

    expect_error(get_genes("CRP", page = -1),
      regexp = "`page`: ensure this value is greater than or equal to 0"
    )
  })
})
