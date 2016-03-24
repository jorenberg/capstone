#!/usr/bin/env r


# Capstone®
# ------------------------------------------
# Predictive Modelling.
# ------------------------------------------
# by Prabhat Kumar, http://prabhatkumar.org/
# Date          : 22-March-2016
# ==========================================
# locale        : en_US.UTF-8
# ==========================================
# Data Source   : SwiftKey, Inc.
# HomePage      : https://swiftkey.com/en/
# ==========================================


# Ω - Specified Environment Access.
envir = .GlobalEnv

if (is.environment(envir)) {
  print("Environment is Global!")
  # ¬ Sampling the SwiftKey Data.
  # Setting the seed for reproducibility.
  set.seed(100)
  
  # This function takes a random sample of the data.
  sampler <- function(chunk, percent) {
    percent <- round(length(chunk)*percent)
    sample.index <- sample(1:length(chunk), percent)
    
    return(chunk[sample.index])
  }
}
