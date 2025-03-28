test_that(
  "`process_resp_body_linkage_disequilibrium()` handles both valid and empty responses",
  {
    # empty response
    expect_equal(
      process_linkage_disequilibrium_resp_json(list(
        data = list(),
        paging_info = list(
          numberOfPages = 0,
          page = 0,
          maxItemsPerPage = 250,
          totalNumberOfItems = 0
        )
      )),
      tibble::tibble()
    )

    # valid response (`get_linkage_disequilibrium_by_variant_data("chr1_153209639_T_C_b38")`)
    expect_equal(
      process_linkage_disequilibrium_resp_json(list(
        data = list(
          list(
            "chr1_153202482_C_T_b38,chr1_153209639_T_C_b38",
            "0.28083400000000003"
          )
        ),
        paging_info = list(
          numberOfPages = 1,
          page = 0,
          maxItemsPerPage = 250,
          totalNumberOfItems = 162
        )
      )),
      tibble::tibble(
        variantId_1 = "chr1_153202482_C_T_b38",
        variantId_2 = "chr1_153209639_T_C_b38",
        ld = 0.28083400000000003 # should be numeric
      )
    )
  }
)

test_that("`process_clustered_expression_resp_json()` raises expected error with invalid `expression_item_name` argument values", {
  resp_body <- list(
    clusters = "clusters",
    medianExonExpression = "medianExonExpression"
  )

  expect_error(
    process_clustered_expression_resp_json(resp_body, expression_item_name = "medianExonExpression_invalid"),
    "Internal gtexr error - incorrect `expression_item_name`: 'medianExonExpression_invalid'"
  )
})
