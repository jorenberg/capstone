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

# ¬ Cleaning the SwiftKey Data.
# working with stringi:
# http://www.rexamine.com/resources/stringi/
# Author: Marek Gagolewski, gagolews@rexamine.com/
library(stringi)

# some removal of non english characters to need to be done to make the data more usable.
# drop non UTF-8 characters.
blogs   <- iconv(enBlogs,   from = "latin1", to = "UTF-8", sub = "")
news    <- iconv(enNews,    from = "latin1", to = "UTF-8", sub = "")
twitter <- iconv(enTwitter, from = "latin1", to = "UTF-8", sub = "")

# Replace Occurrences of a Pattern.
twitter <- stri_replace_all_regex(twitter, "\u2019|`","'")
twitter <- stri_replace_all_regex(twitter, "\u201c|\u201d|u201f|``",'"')

# ¬ Creating a Directory/Folder.
if (!"./data/profanity" %in% dir("./data/")) {
  print("Creating a -Data- Directory, please wait...")
  dir.create("data/profanity", showWarnings = TRUE)
} else {
  list.dirs()
}
