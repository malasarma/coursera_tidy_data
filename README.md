---
title: "README"
author: "Mala Sarma"
date: "Saturday, May 23, 2015"
output: html_document
---


# _run_analysis.R_
## Purpose: 
This R script aims at cleaning a raw data set that tracks a 561--feature vector with time and 
frequency domain variables, on 6 different activities of 30 subjects. This script does the following:

* The raw data set is available separately as testing data and training data. The script first consolidates these 2 data sets into one.
* It then extracts only the measurements on the mean and standard deviation for each measurement. 
* It uses descriptive activity names to name the activities in the data set.
* It appropriately labels the data set with descriptive variable names.
* And, finally, it derives a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to run _run_analysis.R_
* The script requires that you set the working directory to the location of the UCI Machine Learning Repository:
        ![](wd.jpg)
* It also requires you to install the __reshape2__ package
* In an R window, type:
    + source("<path to _run_analysis.R_/run_analysis")
    + run_analysis()
* This will create 2 files of the tidy data set:
    + **_tidy.csv_**
    + **_tidy.txt_**
    
## How _run_analysis.R_ works
* First it reads _activities_labels.txt_ and _features.txt_ and saves them in data frames
* Then it reads the 2 raw data sets in _test/X_test.txt_, and _train/X_test.txt_ and saves them in data frames(_test_ and _train_)
* Next, it combines these two tables into one data set, _main_table_  **(Step 1)**
* It extracts only the measurements on the mean and standard deviation for each measurement into a table, _sub_table_ **(Step 2)**
* It then reads _test/y_test.txt_, and _train/y_test.txt_ for the Activities, uses the descriptive activity names to name the activities and creates an additional column for the Activities in _sub_table_ **(Step 3)**
* It also reads _test/X_test.txt_, and _train/X_test.txt_ to include the Subjects information and creates an additional column for the Subjects in _sub_table_
* It appropriately labels the data set with descriptive variable names **(Step 4)**
* Finally it creates a second, independent tidy data set with the average of each variable for each activity and each subject, using the _melt_ and _dcast_ functions in the **reshape2** package. It saves the tidy data set in both _csv_ and _txt_ formats. **(Step 5)**

## Additional information
* Please see the [codebook.md]() file for more details on the variables in the tidy data set