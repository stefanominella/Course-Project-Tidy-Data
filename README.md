Course-Project-Tidy-Data
========================

Repository for course project Getting and Cleaning Data - Coursera

NOTICE: dear peer, please notice that due to my underperformant laptop,
I was only able to generate a small sample of tidy data set by processing only the data for 2 activities of 2 subjects.
So please be appreciative of my effort to submit my work at my best.


The script run_analysis.R aims to generate a tidy dataset through the following steps:


1. load source data files
2. label the measurements dataset variables using the labels from the features.txt file. 
3. add the subject and activity codes as new columns to the measurements dataset.
4. merge the test and train measurements datasets together.
5. extract only the measurements from mean,std and activity, subject codes. 
6. merge the activity_labels.txt dataset with the measurements dataset to include activities description.
7. appropriately label the measurments dataset with descriptive varibles names removing dashes, parenthesis and abbreviations.
8. compute the average of each variable for each activity and each subject.
9. save the data frame as a txt file into the r working directory.
