Getting and Cleaning Data in R
*****************************************************************

Synopsis
*****************************************************************
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Original Source Data
*****************************************************************
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Steps Performed in Analysis
****************************************************************
1.Data is downloaded from the source and extracted to a directory data
2.Activity data: y_test.txt,y_train.txt is read
3.Subject data: subject_test,subject_train is read
4.Features data: X_test,X_train is read.
5. all the above data is merged into a single dataset called "dataset"
6.dataset is subsetted with measurements on mean and sd with the help of "grepl" command
7.activity_labels.txt is read and it is applied to the activity coloumn 
8. activity and subject is turned into a factor in the new dataset called "Data"
9.proper full names are given using gsub
10. removed intermediate datasets
11. tidydata created with average of each variable for each activity and each subject
