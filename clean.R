#!/usr/bin/env r


# Capstone®
# by Prabhat Kumar, http://prabhatkumar.org/
# Date    :   18-March-2016
# ==========================================
# locale  :   en_US.UTF-8

## Reading/Cleaning SwiftKey Data.
## ===============================
## [01] working with stringi:
## http://www.rexamine.com/resources/stringi/
## Author: Marek Gagolewski, gagolews@rexamine.com/
library(stringi)

# Reading the Data.
blogs   <- readLines("./data/final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul = TRUE)
twitter <- readLines("./data/final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul = TRUE)

con   <- file("./data/final/en_US/en_US.news.txt", open="rb")
news  <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)
rm(con)

# some removal of non english characters to need to be done to make the data more usable.
# drop non UTF-8 characters.
blogs   <- iconv(blogs,   from = "latin1", to = "UTF-8", sub = "")
news    <- iconv(news,    from = "latin1", to = "UTF-8", sub = "")
twitter <- iconv(twitter, from = "latin1", to = "UTF-8", sub = "")

# Replace Occurrences of a Pattern.
twitter <- stri_replace_all_regex(twitter, "\u2019|`","'")
twitter <- stri_replace_all_regex(twitter, "\u201c|\u201d|u201f|``",'"')

# Save a single object to file.
saveRDS(blogs,    "./data/final/en_US/blogs.rds")
saveRDS(news,     "./data/final/en_US/news.rds")
saveRDS(twitter,  "./data/final/en_US/twitter.rds")

# A data frame is a list of variables of the same number of rows with unique row names,
# given class "data.frame". If no variables are included,
# the row names determine the number of rows.
data.frame(blogs = length(blogs), news = length(news), twitter = length(twitter))

# ---------------------------
#   blogs   news      twitter
# 1 899288  1010242   2360148
# ---------------------------
