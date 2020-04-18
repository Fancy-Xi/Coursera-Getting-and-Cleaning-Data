### Getting and Cleaning data Assignment ###

# Download data and unzip it to "UCI HAR Dataset" folder under the working directory
# Read data and assign all data frames
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("no", "functions"))
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "sub")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt", col.names = features$functions)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "sub")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt", col.names = features$functions)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merge the training and test datasets together to create one dataset
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
sub <- rbind(strain, stest)
mergedata <- cbind(sub, Y, X)
# Check dimentions of X,Y,sub, and mergedata dataset
data.frame(x=dim(X), y=dim(Y), s=dim(sub), m=dim(mergedata) )

## Extract the mean and standard deviation for each measurements
TidyData <- mergedata %>% select(sub, code, matches('mean|std'))

## Uses descriptive activity names to name the activities in the data set
TidyData$code <- activity[TidyData$code, 2]

## Appropriately labels the data set with descriptive variable names.
TidyData <- rename(TidyData, activity=code)
# substitute abbreviations to the full word
names(TidyData) <- mgsub::mgsub(names(TidyData), c("Acc", "^t", "Gyro", "BodyBody","Mag", "^f",
                                                   ".mean",".std", "^frequency","angle",".tBody","gravity"), 
                                c("Accelerometer", "Time", "Gyroscope", "Body","Magnitude", 
                                  "Frequency", "Mean", "STD","Frequency","Angle","Timebody","Gravity"))

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Melt the tidy dataset, set subject and activity as id and all other measurements as variables
tidymelt <- melt(TidyData, id= names(TidyData)[1:2], measure.vars=names(TidyData)[3:88])
# Cast the dataset to report all variables by id and activity
tidycast <- dcast(tidymelt, sub + activity~variable, mean)
# write out the dataset as csv files
write.csv(tidycast, "FinalData.csv")
write.csv(TidyData, "TidyData.csv")











