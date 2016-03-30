## Algorithms for Capstone®.
The Heart of Capstone®, <i>i.e.</i>, Shiny Prediction Application is an efficient and smart <b>prediction algorithm</b>, driven by Statistics, Computational Linguistics, Natural Language Processing and Machine Learning.

The driving force of this project is; Understanding the Problem (including Data Mining techniques), Exploratory Data Analysis and Modelling (including Profanity Filtering and Sampling), Prediction Model by using the ```n-gram``` and ```back-off models```, and Evaluation of the build model for efficiency & accuracy by using different metrics like perplexity, accuracy at the ```uni-gram```, ```bi-gram```, and ```tri-gram```.

<b>Here</b>, is the implementation of ```n-gram``` model in `R` language:

```{r}
# Computational Linguistics.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~
# A function that creates n-grams.
# ================================
# an n-gram is a contiguous sequence of n-items from a given sequence of text or speech.
# An n-gram of size 1 is referred to as a "unigram";
# size 2 is a "bigram" (or, less commonly, a "digram");
# size 3 is a "trigram".
# ======================================================================================
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
```
