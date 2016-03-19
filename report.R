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


## [04] Summary Statistics for the 3 files.
## en_US.blogs/en_US.news/en_US.twitter
## ========================================
blogwords    <- sum(stri_count_words(blogs))
newswords    <- sum(stri_count_words(news))
twitterwords <- sum(stri_count_words(twitter))
# Combine Values into a Vector or List,
# This is a generic function which combines its arguments.
words        <- c(blogwords, newswords, twitterwords)

bloglines    <- length(blogs)
newslines    <- length(news)
twitterlines <- length(twitter)
# Combine Values into a Vector or List,
# This is a generic function which combines its arguments.
lines        <- c(bloglines, newslines, twitterlines)

blogmaxc     <- max(nchar(blogs))
newsmaxc     <- max(nchar(news))
twittermaxc  <- max(nchar(twitter))
# Combine Values into a Vector or List,
# This is a generic function which combines its arguments.
maxchars     <- c(blogmaxc, newsmaxc, twittermaxc)

blogmaxw     <- max(stri_count_words(blogs))
newsmaxw     <- max(stri_count_words(news))
twittermaxw  <- max(stri_count_words(twitter))
# Combine Values into a Vector or List,
# This is a generic function which combines its arguments.
maxwords     <- c(blogmaxw, newsmaxw, twittermaxw)

FileSumm     <- data.frame("File Name" = c("en_US.blogs", "en_US.news", "en_US.twitter"),
                           NumberLines = lines,
                           NumberWords = words,
                           MaxChars = maxchars,
                           MaxWords = maxwords)

# Summaries
summary(FileSumm)

# -------------------------------------------------------------------------------------
# File.Name           NumberLines       NumberWords         MaxChars        MaxWords
# -------------------------------------------------------------------------------------
# en_US.blogs  :1   Min.   : 899288   Min.   :30195133   Min.   :  213   Min.   :  61.0
# en_US.news   :1   1st Qu.: 954765   1st Qu.:32605938   1st Qu.: 5798   1st Qu.: 928.5
# en_US.twitter:1   Median :1010242   Median :35016742   Median :11384   Median :1796.0
#                   Mean   :1423226   Mean   :34455214   Mean   :17477   Mean   :2861.0
#                   3rd Qu.:1685195   3rd Qu.:36585254   3rd Qu.:26110   3rd Qu.:4261.0
#                   Max.   :2360148   Max.   :38153767   Max.   :40835   Max.   :6726.0
# -------------------------------------------------------------------------------------


## [05] Basic descriptive measures of the size of the text.
## ========================================================
## working with knitr:
library(knitr)

basic.measures <- cbind(c("Text Chunks", "Characters"),
                  rbind(c(length(blogs),length(news),length(twitter)),
                        c(sum(nchar(blogs)),sum(nchar(news)),sum(nchar(twitter)))))
colnames(basic.measures) <- c("Measure", "Blogs", "News", "Twitter")

kable(basic.measures)

# Summaries
# -------------------------------------------------------------------------------------
# Measure           Blogs           News        Twitter
# Characters :1   208361438:1   1010242  :1   162385035:1
# Text Chunks:1   899288   :1   203791405:1   2360148  :1
# -------------------------------------------------------------------------------------
