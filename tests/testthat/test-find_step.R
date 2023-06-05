# Jeu de données exemples -------------------------------------------------
tb <- tibble::tribble(
  ~element, ~dependency,
  "F88", NA,
  "F89", "F88",
  "F90", "F89",
  "F91", "F89",
  "F92", "F90",
  "F92", "F91",
  "F93", "F92",
  "F94", "F93",
  "F95", "F94",
  "F96", "F94",
  "F97", "F94",
  "F98", "F94"
)

tb <- tibble::tibble(
  element = c("a", "b", "c", "d", "e", "e"),
  dependency = c(NA, "a", "a", NA, "c", "d")
)

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


# find_step(tb)
#
# find_step(tb, step_type = "all")
# find_step(tb, step_type = "all", collapse = FALSE)
#
# find_step(tb, step_type = "max")
# find_step(tb, step_type = "max", collapse = FALSE)
#
# find_step(tb, step_type = "min")
# find_step(tb, step_type = "min", collapse = FALSE)
