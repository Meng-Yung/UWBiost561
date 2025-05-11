#' Generate a Random Graph with a Partial Clique
#'
#' @param n Integer. Total number of nodes in the graph. Must be a positive integer.
#' @param clique_fraction Numeric between 0 and 1. Fraction of nodes to include in the partial clique. The actual number of clique nodes is round(n * clique_fraction).
#' @param clique_edge_density Numeric between 0 and 1. Target edge density among the nodes in the partial clique (e.g., 1 = fully connected, 0 = no edges).
#' @param density_rest Numeric between 0 and 1. Edge density for the rest of the graph outside the partial clique. Defaults to 0.1.
#'
#' @returns A list with the following elements:
#' adj_mat, An n x n symmetric adjacency matrix with binary entries (0 or 1), with 1s on the diagonal. A partial clique of appropriate size and density is embedded.
#' rev_order, An integer vector of length n indicating the permutation of node labels used to randomize the row/column order of the matrix.
#' @export
#'
#' @examples  generate_partial_clique(n = 10, clique_fraction = 0.5, clique_edge_density = 0.9)
generate_partial_clique <- function(n, clique_fraction, clique_edge_density, density_rest = 0.1){
  # Checking inputs
  stopifnot(
    n%%1 == 0,
    n >= 0,
    clique_fraction >= 0,
    clique_fraction <= 1,
    clique_edge_density >= 0,
    clique_edge_density<= 1)

  # Getting size of partial clique
  m <- round(n * clique_fraction)
  adj_mat <- matrix(0, nrow = n, ncol = n)

  # Generating the partial clique
  max_edges <- m * (m - 1) / 2
  num_edges <- round(clique_edge_density * max_edges)

  # Randomly choose edges within the clique
  clique_indices <- 1:m
  clique_pairs <- combn(clique_indices, 2)
  selected_edges <- clique_pairs[, sample(ncol(clique_pairs), num_edges)]

  for (i in 1:ncol(selected_edges)) {
    a <- selected_edges[1, i]
    b <- selected_edges[2, i]
    adj_mat[a, b] <- 1
    adj_mat[b, a] <- 1
  }

  # Add random edges to the rest of the graph
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      if (i > m || j > m) {  # avoid overwriting partial clique
        if (runif(1) < density_rest) {
          adj_mat[i, j] <- 1
          adj_mat[j, i] <- 1
        }
      }
    }
  }

  # Ensure diagonal = 1
  diag(adj_mat) <- 1

  # Randomly permute node labels
  sample_idx <- sample(1:n)
  adj_mat <- adj_mat[sample_idx, sample_idx]

  # Return matrix and permutation for reference
  return(list(adj_mat = adj_mat, rev_order = order(sample_idx)))
}
