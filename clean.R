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

## Sampling of SwiftKey Data.
## ==========================
## [02] working with RWeka:
## An R interface to Weka:
## Weka is a collection of machine learning algorithms for data mining.
## https://cran.r-project.org/web/packages/RWeka/index.html
library(RWeka)
Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))

# Due to the large amount of text and limited computational resources,
# sampling is performed. 10000 lines per file is randomly sampled and saved to disk.
sample_blogs    <- sample(blogs,    10000)
sample_news     <- sample(news,     10000)
sample_twitter  <- sample(twitter,  10000)

# To write sample data.
writeLines(c(sample_twitter, sample_news, sample_blogs), "./sample_data.txt")
# -- 4.8 MB.

## Summary Statistics for the 3 files.
## ===================================
blogwords    <- sum(stri_count_words(blogs))
newswords    <- sum(stri_count_words(news))
twitterwords <- sum(stri_count_words(twitter))
words        <- c(blogwords, newswords, twitterwords)

bloglines    <- length(blogs)
newslines    <- length(news)
twitterlines <- length(twitter)
lines        <- c(bloglines, newslines, twitterlines)

blogmaxc     <- max(nchar(blogs))
newsmaxc     <- max(nchar(news))
twittermaxc  <- max(nchar(twitter))
maxchars     <- c(blogmaxc, newsmaxc, twittermaxc)

blogmaxw     <- max(stri_count_words(blogs))
newsmaxw     <- max(stri_count_words(news))
twittermaxw  <- max(stri_count_words(twitter))
maxwords     <- c(blogmaxw, newsmaxw, twittermaxw)

FileSumm     <- data.frame("File Name" = c("en_US.blogs", "en_US.news", "en_US.twitter"),
                           NumberLines = lines,
                           NumberWords = words,
                           MaxChars = maxchars,
                           MaxWords = maxwords)

# Summaries
summary(FileSumm)

# File.Name           NumberLines       NumberWords         MaxChars        MaxWords
# -------------------------------------------------------------------------------------
# en_US.blogs  :1   Min.   : 899288   Min.   :30195133   Min.   :  213   Min.   :  61.0
# en_US.news   :1   1st Qu.: 954765   1st Qu.:32605938   1st Qu.: 5798   1st Qu.: 928.5
# en_US.twitter:1   Median :1010242   Median :35016742   Median :11384   Median :1796.0
#                   Mean   :1423226   Mean   :34455214   Mean   :17477   Mean   :2861.0
#                   3rd Qu.:1685195   3rd Qu.:36585254   3rd Qu.:26110   3rd Qu.:4261.0
#                   Max.   :2360148   Max.   :38153767   Max.   :40835   Max.   :6726.0
# -------------------------------------------------------------------------------------
