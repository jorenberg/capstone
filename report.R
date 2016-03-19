#!/usr/bin/env r


# Capstone®
# ------------------------------------------
# Exploratory Data Analysis and Modelling.
# ------------------------------------------
# by Prabhat Kumar, http://prabhatkumar.org/
# Date    :   18-March-2016
# ==========================================
# locale  :   en_US.UTF-8
# ==========================================
# Data Source   : SwiftKey, Inc.
# HomePage      : https://swiftkey.com/en/
# ==========================================


## [01] Loading the SwiftKey Data.
## ===============================
dataURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(dataURL, destfile = "./data/SwiftKey.zip", method = "curl")
# unlink deletes the file(s) or directories specified by x.
unlink(dataURL, recursive = FALSE, force = FALSE)
# The bash command unzip is used for opening the archive.
unzip("./data/SwiftKey.zip")


## [02] Reading the SwiftKey Data.
## ===============================
enBlogs   <- readLines("./data/final/en_US/en_US.blogs.txt",   encoding = "UTF-8", skipNul = TRUE)
enNews    <- readLines("./data/final/en_US/en_US.news.txt",    encoding = "UTF-8", skipNul = TRUE)
enTwitter <- readLines("./data/final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul = TRUE)


## [03] Cleaning the SwiftKey Data.
## ================================
## working with stringi:
## http://www.rexamine.com/resources/stringi/
## Author: Marek Gagolewski, gagolews@rexamine.com/
library(stringi)

# some removal of non english characters to need to be done to make the data more usable.
# drop non UTF-8 characters.
blogs   <- iconv(enBlogs,   from = "latin1", to = "UTF-8", sub = "")
news    <- iconv(enNews,    from = "latin1", to = "UTF-8", sub = "")
twitter <- iconv(enTwitter, from = "latin1", to = "UTF-8", sub = "")

# Replace Occurrences of a Pattern.
twitter <- stri_replace_all_regex(twitter, "\u2019|`","'")
twitter <- stri_replace_all_regex(twitter, "\u201c|\u201d|u201f|``",'"')

# Save a single object to file.
saveRDS(blogs,   "./enBlogs.rds")
saveRDS(news,    "./enNews.rds")
saveRDS(twitter, "./enTwitter.rds")

# A data frame is a list of variables of the same number of rows with unique row names,
# given class "data.frame". If no variables are included,
# the row names determine the number of rows.
data.frame(blogs = length(blogs), news = length(news), twitter = length(twitter))

# ---------------------------
#   blogs   news      twitter
# 1 899288  1010242   2360148
# class     :       character
# ---------------------------
