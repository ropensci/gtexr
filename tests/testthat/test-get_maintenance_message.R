test_that("`get_maintenance_message()` returns a tibble", {
  skip_if_offline()
  expect_s3_class(
    get_maintenance_message(),
    "tbl_df"
  )
})
