#!/usr/bin/env r


# Capstone®
# ------------------------------------------
# To Plotting of the SwiftKey Data.
# ------------------------------------------
# by Prabhat Kumar, http://prabhatkumar.org/
# Date    :   20-March-2016
# ==========================================
# locale  :   en_US.UTF-8
# ==========================================
# Data Source   : SwiftKey, Inc.
# HomePage      : https://swiftkey.com/en/
# ==========================================


library(ggplot2)
# http://ggplot2.org/
library(RColorBrewer)
# http://colorbrewer2.org/

## A function that plot n-grams.
## =============================
n.gram.plot <- function(n.gram.df, topn, name) {
  custom.pal <- colorRampPalette(brewer.pal(6,"Blues"))(15)
  
  ggplot(n.gram.df[1:topn,], aes(x = N.Gram, y = Prop, fill = Prop)) + 
    geom_bar(stat = "identity") + 
    scale_fill_gradient(low = custom.pal[5], high = custom.pal[10]) + 
    ggtitle(name) + 
    coord_flip() + 
    theme(legend.position = "none")
}

# blogs n-grams plot.
n.gram.plot(blogs.1.gram, 10, "Blogs unigram Relative Proportions.")
n.gram.plot(blogs.2.gram, 10, "Blogs bigram Relative Proportions.")
n.gram.plot(blogs.3.gram, 10, "Blogs trigram Relative Proportions.")

# twitter n-grams plot.
n.gram.plot(twitter.1.gram, 10, "Twitter unigram Relative Proportions.")
n.gram.plot(twitter.2.gram, 10, "Twitter bigram Relative Proportions.")
n.gram.plot(twitter.3.gram, 10, "Twitter trigram Relative Proportions.")
