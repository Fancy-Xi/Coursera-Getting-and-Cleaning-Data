# Peer-graded Assignment: Getting and Cleaning Data Course Project
   This repository contains files created and submitted by Xi Fang for Getting and Cleaning Data course project. It has the instructions and all the steps description on how to run analysis on Human Activity recognition dataset.

# Dataset
   + Human Activity Recognition Using Smartphones
   + datasource: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Files Description
   + CodeBook.md a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

   + run_analysis.R include all the code I performed according to the 5 steps required as described in the course project’s requirements:
      + 1. Merges the training and the test sets to create one data set.
      + 2. Extracts only the measurements on the mean and standard deviation for each measurement.
      + 3. Uses descriptive activity names to name the activities in the data set
      + 4. Appropriately labels the data set with descriptive variable names.
      + 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   + TidyData.csv is the tidy data created from the original dataset performed from step 1 to step 4
   + FinalData.csv is the exported final data after going through all the steps described above with means of all variables for each subject and activity.