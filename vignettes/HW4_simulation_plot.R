rm(list=ls())
load("./vignettes/HW4_simulation.RData")
library(ggplot2)
library(cowplot)

# the plot we would like to make is:
# For different values of n, how often each of the 15 methods
# get the maximal partial clique (over the trials)

# Loop over different values of n (6 to 10)
ggplot_list <- lapply(n_numbers, function(n_val){
  # Collect results across trials for this n
  trial_mat <- sapply(level_trial_list, function(trial_list){
    # Extract the result list for each implementation at this n
    result_list <- lapply(trial_list, function(imp_list) {
      imp_list[[paste("n =", n_val)]]
    })

    # Check validity (NULL = invalid)
    bool_vec <- sapply(result_list, function(x) {
      if (is.null(x)) return(FALSE)
      if (is.null(x$valid)) return(FALSE)
      return(x$valid)
    })

    # Get clique indices
    clique_list <- lapply(result_list, function(x) {
      if (is.null(x)) return(integer(0))
      return(x$clique_idx)
    })

    # Find valid results
    valid_idx <- which(bool_vec == TRUE)
    clique_list_valid <- clique_list[valid_idx]

    # Find size of valid cliques
    size_vec_valid <- sapply(clique_list_valid, length)
    if (length(size_vec_valid) == 0) {
      winner_vec <- rep(FALSE, length = length(result_list))
    } else {
      max_size <- max(size_vec_valid)
      winning_methods <- valid_idx[which(size_vec_valid == max_size)]

      winner_vec <- rep(FALSE, length = length(result_list))
      winner_vec[winning_methods] <- TRUE
    }

    names(winner_vec) <- as.character(1:15)
    return(winner_vec)
  })

  # Summarize number of wins for each method
  tabulate_vec <- rowSums(trial_mat)
  method_names <- as.character(1:15)

  df <- data.frame(method = method_names,
                   number_wins = tabulate_vec)

  gg <- ggplot2::ggplot(df, ggplot2::aes(x=method, y=number_wins))
  gg <- gg + ggplot2::geom_bar(stat = "identity")
  gg <- gg + ggplot2::scale_x_discrete(limits = method_names)
  gg <- gg + ggplot2::labs(x = "Method",
                           y = "Number of wins",
                           title = paste("For n =", n_val))
  return(gg)
})

# Combine all plots into one
plot_all <- cowplot::plot_grid(plotlist = ggplot_list, ncol = 1)

# Save the plot
ggplot2::ggsave(plot_all, file = "./vignettes/HW4_simulation.png",
                height = 10, width = 9, units = "in")
