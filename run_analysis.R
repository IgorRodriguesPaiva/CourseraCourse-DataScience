## Downloading data:

if (!file.exists("DataFinalProject.zip")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, "DataFinalProject.zip", method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip("DataFinalProject.zip") 
}

## Loading data:

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("task_code", "task"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merging the training and the test sets to create one data set.:
Xdata <- rbind(x_train, x_test)
Ydata <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
MergedData <- cbind(Subject, Ydata, Xdata)

## MergedData is our dataset.

## Extracting only the measurements on the mean and 
## standard deviation for each measurement. I used the select
## command to get only the subject and code colummns and also
## the colummns that show the std and mean for each measurement.
CleanData <- select(MergedData, subject, code, contains("mean"), contains("std"))


## Here I used the descriptive activity names, present on the
## activity_labels table, in order to name the activities in the data set:
CleanData$code <- activity_labels[CleanData$code, 2]

## Appropriately labels the data set with descriptive variable names.
names(CleanData)[2] = "Tasks"
names(CleanData)<-gsub("Acc", "Accelerometer", names(CleanData))
names(CleanData)<-gsub("^t", "Time", names(CleanData))
names(CleanData)<-gsub("^f", "Frequency", names(CleanData))
names(CleanData)<-gsub("BodyBody", "Body", names(CleanData))
names(CleanData)<-gsub("Gyro", "Gyroscope", names(CleanData))
names(CleanData)<-gsub("Mag", "Magnitude", names(CleanData))
names(CleanData)<-gsub("angle", "Angle", names(CleanData))
names(CleanData)<-gsub("mean", "Mean", names(CleanData), ignore.case = TRUE)
names(CleanData)<-gsub("gravity", "Gravity", names(CleanData))
names(CleanData)<-gsub("MeanFreq", "MeanFrequency", names(CleanData))

## From the data set CleanData, now we creates a second, independent 
## tidy data set with the average of each variable for each activity 
## and each subject.

SecondTidyData <- group_by(CleanData, subject, Tasks) %>%
                  summarise_all(list(mean = mean))    
write.table(SecondTidyData, "SecondTidyData.txt", row.name = FALSE )

SecondTidyData

