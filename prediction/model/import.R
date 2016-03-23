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


# Ω - Remove Objects from a Specified Environment.
rm(list = ls())

# ¬ Reading the SwiftKey Data.
enBlogs   <- readLines("./data/final/en_US/en_US.blogs.txt",   encoding = "UTF-8", skipNul = TRUE)
enNews    <- readLines("./data/final/en_US/en_US.news.txt",    encoding = "UTF-8", skipNul = TRUE)
enTwitter <- readLines("./data/final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul = TRUE)
