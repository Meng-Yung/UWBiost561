context("Testing generate_partial_clique")

test_that("generate_partial_clique works", {
  set.seed(10)
  res <- generate_partial_clique(n = 10,
                                 clique_fraction = 0.5,
                                 clique_edge_density = 0.9)

  expect_true(is.list(res))
  expect_true(is.matrix(res$adj_mat))
  expect_true(all(dim(res$adj_mat) == c(10,10)))
})

test_that("generate_partial_clique handles more extreme graph sizes", {
  set.seed(20)

  # Test with a smaller graph (n = 5)
  res_small <- generate_partial_clique(n = 5,
                                       clique_fraction = 0.6,
                                       clique_edge_density = 0.7)
  expect_true(is.matrix(res_small$adj_mat))
  expect_true(all(dim(res_small$adj_mat) == c(5, 5)))

  # Test with a larger graph (n = 50)
  res_large <- generate_partial_clique(n = 50,
                                       clique_fraction = 0.4,
                                       clique_edge_density = 0.5)
  expect_true(is.matrix(res_large$adj_mat))
  expect_true(all(dim(res_large$adj_mat) == c(50, 50)))
})
