#!/usr/bin/env r


# Capstone®
# by Prabhat Kumar, http://prabhatkumar.org/
# Date    :   08-March-2016
# ==========================================
# locale  :   en_US.UTF-8

## [01] Setting the Working Directory.
setwd("/Users/iamprabhat/Documents/Capstone")

## [02] List the Files in a Directory/Folder.
list.dirs()

## [03] Creating a Directory/Folder.
dir.create("data", showWarnings = TRUE)

## [04] Specify the source and destination of the download.
fileURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(fileURL, destfile = "data/SwiftKey.zip", method = "curl")
unlink(fileURL)
# Unzip the data.
unzip("SwiftKey.zip")
