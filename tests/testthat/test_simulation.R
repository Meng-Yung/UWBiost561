test_that("imp_numbers is a valid set of numbers between 1 and 15", {
  # Example of imp_numbers with any combination of numbers between 1 and 15
  imp_numbers <- sample(1:15, 10)  # Can be any combination, no specific order

  # Check if imp_numbers is a numeric vector
  expect_true(is.numeric(imp_numbers))

  # Check if all numbers are between 1 and 15
  expect_true(all(imp_numbers >= 1 & imp_numbers <= 15))

  # Check if imp_numbers contains unique values (since it's a set)
  expect_equal(length(imp_numbers), length(unique(imp_numbers)))
})

test_that("trials is a positive integer within a reasonable range", {
  trials <- 5

  # Check if trials is a single positive integer
  expect_true(is.numeric(trials))
  expect_true(length(trials) == 1)
  expect_true(trials > 0)

  # Check if trials is within a reasonable range (e.g., 1 to 100)
  expect_true(trials <= 100)
})

test_that("n_numbers is a valid set of numbers between 5 and 50", {
  # Example of n_numbers with any combination of numbers between 5 and 50
  n_numbers <- sample(5:50, 10)  # Can be any combination, no specific order

  # Check if n_numbers is a numeric vector
  expect_true(is.numeric(n_numbers))

  # Check if all numbers are between 5 and 50
  expect_true(all(n_numbers >= 5 & n_numbers <= 50))

  # Check if n_numbers contains unique values (since it's a set)
  expect_equal(length(n_numbers), length(unique(n_numbers)))
})
