rm(list=ls())
set.seed(10)
library(UWBiost561)

imp_numbers <- 1:15
trials <- 5
n_numbers <- 6:10  # Fixed alpha

# Generate the simulation
level_trial_list <- lapply(1:trials, function(trial){
  print(paste("Working on Trial:", trial))
  set.seed(trial)  # Freeze randomness for this trial

  # Loop over the different implementations (imp_numbers)
  trial_result_list <- lapply(imp_numbers, function(imp_number){
    print(paste("Working on Implementation:", imp_number))

    # Loop over n values from 5 to 10 for each implementation
    result_n_list <- lapply(n_numbers, function(n){
      set.seed(trial)  # To freeze the randomness of adj_mat generation
      print(paste("Generating with n =", n))

      # Generate the adjacency matrix with varying n (5 to 10)
      data <- UWBiost561::generate_partial_clique(n = n,
                                                  clique_fraction = 0.5,
                                                  clique_edge_density = 0.95)
      adj_mat <- data$adj_mat

      print("generated adj_mat:")

      print(adj_mat)

      # Compute the maximal partial clique for this n and imp_number
      result <- UWBiost561::compute_maximal_partial_clique_master(
        adj_mat = adj_mat,
        alpha = 0.95,
        number = imp_number,
        time_limit = 30
      )

      return(result)
    })

    names(result_n_list) <- paste("n =", 6:10)
    return(result_n_list)
  })

  names(trial_result_list) <- paste("Implementation:", imp_numbers)
  return(trial_result_list)
})

names(level_trial_list) <- paste("Trial:", 1:trials)

# Save results
date_of_run <- Sys.time()
session_info <- devtools::session_info()

save(level_trial_list,  # Save your results
     alpha,              # Save the fixed alpha value
     date_of_run,
     session_info,
     file = "~/demo_simulation_vary_n.RData")
