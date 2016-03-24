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

# ¬ Let's start off with a 20% sample data.
#                         -----
(function(){
  if (!"./data/sample" %in% dir("./data/")) {
    print("Creating a -Sample- Directory, please wait...")
    dir.create("data/sample", showWarnings = TRUE)
  }
  
  print("Making 20% of sample data...")
  
  # //1-US.blogs//
  sampleBlogs <- sampler(blogs, .20)
  # Write Lines to a Connection.
  writeLines(c(sampleBlogs), "./data/sample/sampleBlogs.txt")
  
  # //2-US.news//
  sampleNews <- sampler(news, .20)
  # Write Lines to a Connection.
  writeLines(c(sampleNews), "./data/sample/sampleNews.txt")
  
  # //3-US.twitter//
  sampleTwitter <- sampler(twitter, .20)
  # Write Lines to a Connection.
  writeLines(c(sampleTwitter), "./data/sample/sampleTwitter.txt")
  
  # List the Files in a Directory/Folder.
  list.dirs(path = "./data", full.names = TRUE, recursive = TRUE)
  
  # Information about Files.
  file.info("./data/sample/sampleBlogs.txt")
  file.info("./data/sample/sampleNews.txt")
  file.info("./data/sample/sampleTwitter.txt")
  
  print("Files are written, in text format.")

})()
