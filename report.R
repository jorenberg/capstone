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
