context("Testing compute_maximal_partial_clique")

# Check if the output format is correct.
test_that("Output format is correct", {
  adj <- diag(1, 6)
  adj[lower.tri(adj)] <- 1
  adj[upper.tri(adj)] <- t(adj)[upper.tri(adj)]

  res <- compute_maximal_partial_clique(adj, 0.6)

  expect_true(is.list(res))
  expect_true("clique_idx" %in% names(res))
  expect_true("edge_density" %in% names(res))
  expect_true(is.numeric(res$clique_idx))
  expect_true(is.numeric(res$edge_density))
})

# Check if the output is in the correct range.
test_that("Edge density is in the correct range", {
  adj <- matrix(1, nrow = 6, ncol = 6)
  adj[1, 2] <- adj[2, 1] <- 0
  diag(adj) <- 1

  res <- compute_maximal_partial_clique(adj, 0.7)

  expect_gte(res$edge_density, 0.7)
  expect_lte(res$edge_density, 1.0)
})

# Check if function runs on different outputs. (GPT assitance for loop)
test_that("Function works on various valid inputs", {
  sizes <- c(5, 10, 25)
  alphas <- c(0.5, 0.75, 0.9)

  for (size in sizes) {
    for (alpha in alphas) {
      adj <- diag(1, size)
      adj[lower.tri(adj)] <- sample(c(0, 1), size = choose(size, 2), replace = TRUE)
      adj <- adj + t(adj)
      diag(adj) <- 1

      res <- compute_maximal_partial_clique(adj, alpha)
      expect_true(is.numeric(res$clique_idx))
      expect_gte(res$edge_density, alpha)
    }
  }
})

# Check if function gives the correct answer on a crafted problem.
test_that("Function gives correct result on a crafted input", {
  adj <- diag(1, 6)
  # Create a clique of nodes 1 to 4 (6 edges out of 6 possible)
  clique_nodes <- 1:4
  for (i in clique_nodes) {
    for (j in clique_nodes) {
      if (i != j) adj[i, j] <- 1
    }
  }

  # Add non-connected nodes
  adj[5, 6] <- adj[6, 5] <- 0

  res <- compute_maximal_partial_clique(adj, 1.0)

  expect_true(all(res$clique_idx %in% clique_nodes))
  expect_equal(res$edge_density, 1.0)
})

# Check if function gives correct answer with randomly generated problem.
test_that("Function identifies clique from generated partial graph", {
  set.seed(123)
  n <- 20
  clique_frac <- 0.4
  clique_density <- 0.85

  gen <- generate_partial_clique(n = n,
                                 clique_fraction = clique_frac,
                                 clique_edge_density = clique_density)

  adj <- gen$adj_mat
  rev_order <- gen$rev_order
  m <- round(n * clique_frac)
  original_clique_nodes <- rev_order[1:m]

  result <- compute_maximal_partial_clique(adj, alpha = clique_density)

  # Check that the result has high enough density
  expect_gte(result$edge_density, clique_density)

  # Check that the clique includes at least most of the planted clique
  overlap <- intersect(result$clique_idx, original_clique_nodes)
  expect_gte(length(overlap), floor(0.8 * m))  # at least 80% of true clique recovered
})
