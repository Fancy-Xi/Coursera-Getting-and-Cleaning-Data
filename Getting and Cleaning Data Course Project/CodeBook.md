# Peer-graded Assignment: Getting and Cleaning Data Course Project
## Author: Xi Fang
### 4/18/2020

#### Project description
This project aims to collect and clean a dataset for future analysis.

#### Source data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### Data description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#### Data cleaning processes
##### 1. Download dataset
   Dataset was downloaded and extracted in working directory in folder 'UCI HAR Dataset'
   
##### 2. Read data and assign all data frames
1. activity <- activity_labels.txt: 
   + 'data.frame':	6 obs. of  2 variables
   + list of activity performed 
2. features <- features.txt: 'data.frame':	
   + 561 obs. of  2 variables
   + features comes from accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
3. stest <- test/subject_test.txt: 
   + 'data.frame':	2947 obs. of  1 variable
   + test data of volunteer test subjects being observed
4. x_test <- test/x_test.txt:
   + 'data.frame':	2947 obs. of  561 variables
   + recorded features test data
5. y_test <- test/y_test.txt:
   + 'data.frame':	2947 obs. of  1 variable
   + test data of activities code labels
6. strain <- train/subject_train.txt
   + 'data.frame':	7352 obs. of  1 variable
   + train data of volunteer subjects observed
7. x_train <- train/x_train.txt:
   + 'data.frame':	7352 obs. of  561 variables
   + recorded features train data
8. y_train <- train/y_train.txt:
   + 'data.frame':	7352 obs. of  1 variable
   + train data of activities code labels
   
##### 3. Merges the training and the test sets to create one data set
+ X <- rbind(x_train, x_test) # bind train and test for x
   + 'data.frame':	10299 obs. of  561 variables
+ Y <- rbind(y_train, y_test) # bind train and test for y
   + 'data.frame':	10299 obs. of  1 variable
+ sub <- rbind(strain, stest) # bind train and test for subject
   + 'data.frame':	10299 obs. of  1 variable
+ mergedata <- cbind(sub, Y, X) # merge the binded data of x, y, and subject
   + 'data.frame':	10299 obs. of  563 variables
   
#### 4. Extracts only the measurements on the mean and standard deviation for each measurement
+ TidyData <- mergedata %>% select(sub, code, matches('mean|std'))
   + select variables with mean or std in the name and put it in TidyData
   
#### 5. Uses descriptive activity names to name the activities in the data set
+ TidyData$code <- activity[TidyData$code, 2]

#### 6. Appropriately labels the data set with descriptive variable names.
+ TidyData <- rename(TidyData, activity=code)
+ substitute abbreviations to the full word
   + names(TidyData) <- mgsub::mgsub(names(TidyData), c("Acc", "^t", "Gyro", "BodyBody","Mag", "^f",".mean",".std", "^frequency","angle",".tBody","gravity"), c("Accelerometer", "Time", "Gyroscope", "Body","Magnitude", "Frequency", "Mean", "STD","Frequency","Angle","Timebody","Gravity"))

#### 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
+ Melt the tidy dataset, set subject and activity as id and all other measurements as variables
   + tidymelt <- melt(TidyData, id= names(TidyData)[1:2], measure.vars=names(TidyData)[3:88])
+ Cast the dataset to report all variables by id and activity
   + tidycast <- dcast(tidymelt, sub + activity~variable, mean)
   
#### 8. write out the dataset as csv files
write.csv(tidycast, "FinalData.csv")
write.csv(TidyData, "TidyData.csv")
   
   
   
   
   
   
   
   