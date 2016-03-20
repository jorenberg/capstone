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

# Remove Objects from a Specified Environment.
rm(list = ls())

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


## [06] Sampling the SwiftKey Data.
## ================================
# Setting the seed for reproducibility.
set.seed(100)

# This function takes a random sample of the data.
sampler <- function(chunk, percent) {
  percent <- round(length(chunk)*percent)
  sample.index <- sample(1:length(chunk), percent)
  
  return(chunk[sample.index])
}

# Let's start off with a 05% sample data.
#                       -----
# //1-US.blogs//
sampleBlogs <- sampler(blogs, .05)
# Write Lines to a Connection.
writeLines(c(sampleBlogs), "./sampleBlogs.txt")

# //2-US.news//
sampleNews <- sampler(news, .05)
# Write Lines to a Connection.
writeLines(c(sampleNews), "./sampleNews.txt")

# //3-US.twitter//
sampleTwitter <- sampler(twitter, .05)
# Write Lines to a Connection.
writeLines(c(sampleTwitter), "./sampleTwitter.txt")


## [07] Basic descriptive measures of the size of sample text.
## ===========================================================
## working with knitr:
library(knitr)

basic.measures.1 <- cbind(c("Text Chunks", "Characters"),
                  rbind(c(length(sampleBlogs),length(sampleNews),length(sampleTwitter)),
                        c(sum(nchar(sampleBlogs)),sum(nchar(sampleNews)),sum(nchar(sampleTwitter)))))
colnames(basic.measures.1) <- c("Measure", "Blogs", "News", "Twitter")

kable(basic.measures.1)

# Summaries
# -------------------------------------------------------------------------------------
# Measure           Blogs         News        Twitter
# Characters :1   10355850:1   10141823:1   118007 :1
# Text Chunks:1   44964   :1   50512   :1   8124800:1
# -------------------------------------------------------------------------------------


## [08] Profanity Filtering of SwiftKey Sample Data.
## ================================================
# First list of bad words:------------------------
bad.words.1 <- readLines("./data/Bad_Words_1.txt")
bad.words.1 <- bad.words.1[-length(bad.words.1)]

# Second list of bad words:-----------------------
bad.words.2 <- readLines("./data/Bad_Words_2.txt")
bad.words.2 <- bad.words.2[-1]

bad.words.2 <- substr(x = bad.words.2, start = 1, stop = nchar(bad.words.2)-3)
double.quote.index <- grep(pattern = "\"", x = bad.words.2)

bad.words.2[double.quote.index] <- substr(x = bad.words.2[double.quote.index], start = 2, 
                                          stop = nchar(bad.words.2[double.quote.index])-1)

all.bad.words <- c(bad.words.1, bad.words.2)
all.bad.words <- unique(all.bad.words)
all.bad.words <- paste(all.bad.words, collapse="|")
all.bad.words <- substr(x = all.bad.words, start = 1, stop = nchar(all.bad.words)-1)

bad.words.blogs   <- grep(all.bad.words, sampleBlogs)
bad.words.news    <- grep(all.bad.words, sampleNews)
bad.words.twitter <- grep(all.bad.words, sampleTwitter)

bad.prop.blogs    <- length(bad.words.blogs)/length(sampleBlogs)
bad.prop.news     <- length(bad.words.news)/length(sampleNews)
bad.prop.twitter  <- length(bad.words.twitter)/length(sampleTwitter)

sampleBlogs   <- sampleBlogs[-bad.words.blogs]
sampleNews    <- sampleNews[-bad.words.news]
sampleTwitter <- sampleTwitter[-bad.words.twitter]

# What percentage of the chunks has profanities?
# ˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆ
basic.measures.2 <- cbind(c("Text Chunks", "Characters", "Profanity Percent"),
                    rbind(c(length(sampleBlogs),length(sampleNews),length(sampleTwitter)),
                          c(sum(nchar(sampleBlogs)),sum(nchar(sampleNews)),sum(nchar(sampleTwitter))),
                          round(c(bad.prop.blogs,bad.prop.news,bad.prop.twitter), 4)))
colnames(basic.measures.2) <- c("Measure", "Blogs", "News", "Twitter")

kable(basic.measures.2)

# Summaries
# -------------------------------------------------------------------------------------
# Measure                 Blogs         News        Twitter
# Characters :1         6025558 :1   6952821 :1   6980216:1
# Text Chunks:1         34456   :1   38758   :1   104273 :1
# Profanity Percent:1   0.2337  :1   0.2327  :1   0.1164 :1
# -------------------------------------------------------------------------------------


## [09] Creating Homogeneity in the Data.
## ======================================
## Replace numbers and currency with generic "xnumber" and "xdollars" markers.
generic.numbers <- function(chunk) {
  chunk <- gsub(pattern = "[$](([0-9]+)|([,]*))+ +", replacement = "xdollars ", x = chunk)
  chunk <- gsub(pattern = "\\d+", replacement = "xnumber", x = chunk)
  chunk <- gsub(pattern = "xnumber,xnumber", replacement = "xnumber", x = chunk)
  
  return(chunk)
}

## Separate text into distinc sentences based on (. , ; :).
sentence.splitter <- function(chunk) {
  if(grepl("(*)[.]|[,]|[;];[:] [A-Z](*)", chunk))
    return(strsplit(chunk, "(*)[.]|[,]|[;]|[:] (*)"))
  else(return(chunk))
}

## Combining above functions to get cleaner lists of words.
cleaner <- function(chunk) {
  clean.chunks <- vector(mode = "character")
  for(i in 1:length(chunk)) {
    clean.chunks <- c(clean.chunks, sentence.splitter(generic.numbers(chunk[i]))[[1]])
  }
  # Remove leading and trailing whitespace.
  clean.chunks <- gsub("^\\s+|\\s+$", "", clean.chunks)
  
  return(clean.chunks)
}

# Applying cleaner function, to get cleaner lists of words.
enBlogsList     <- cleaner(sampleBlogs);     rm(sampleBlogs);
enNewsList      <- cleaner(sampleNews);       rm(sampleNews);
enTwitterList   <- cleaner(sampleTwitter); rm(sampleTwitter);

# Removing empty entries from the list.
enBlogsList     <- enBlogsList[enBlogsList != ""]
enNewsList      <- enNewsList[enNewsList != ""]
enTwitterList   <- enTwitterList[enTwitterList != ""]

# To Write Cleaned Sample Data.
# Ω - 19.3 MB
writeLines(c(enBlogsList, enNewsList, enTwitterList), "./clean_sample_data.txt")


## [10] Computational Linguistics.
## ================================
## A function that creates n-grams.
## ================================
## an n-gram is a contiguous sequence of n-items from a given sequence of text or speech.
## An n-gram of size 1 is referred to as a "unigram";
## size 2 is a "bigram" (or, less commonly, a "digram");
## size 3 is a "trigram".
## ======================================================================================
n.gram <- function(sentence, n) {
  sent <- strsplit(sentence, split = " ")
  
  if(length(sent[[1]]) < n)
    return()
  ns <- vector(mode = "character", length = length(sent[[1]])-n+1)
  for(i in 1:(length(sent[[1]])-n+1)) {
    ns[i] <- paste((sent[[1]][i:(i+n-1)]), collapse = " ")
  }
  
  return(ns)
}

## n-gram Example.
n.gram(enTwitterList[100], 2)

## Returning a table of frequency counts for n-grams.
n.gram.table <- function(word_list, n) {
  n.gram.medium <- sapply(word_list, n.gram, n = n)
  n.gram.medium <- table(unlist(n.gram.medium))
  
  props <- n.gram.medium/sum(n.gram.medium)
  
  n.gram.medium <- data.frame(n.gram.medium, props)
  colnames(n.gram.medium) <- c("N.Gram", "Freq"," ", "Prop")
  n.gram.medium <- n.gram.medium[order(-n.gram.medium$Prop), ]
  
  #--// Setup for plotting //--
  n.gram.medium$N.Gram <- factor(n.gram.medium$N.Gram, levels = n.gram.medium$N.Gram[order(n.gram.medium$Freq)])
  
  return(n.gram.medium[,-3])
}

#--// Setup for twitter n-grams //-
twitter.1.gram <- n.gram.table(enTwitterList, n = 1)
twitter.2.gram <- n.gram.table(enTwitterList, n = 2)
twitter.3.gram <- n.gram.table(enTwitterList, n = 3)
