The run_analysis.R script performs accordint to the description on the run_analysis.README.md documment.
Here are a step-by-step description of the program and an explanation of the variables. Each section is divided by part of the text code 
and a description.


############################################### CODE ############################################
##Downloading data:
Dataset downloaded and extracted in a folder named UCI HAR Dataset

##Loading data:

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("task_code", "task"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

################################################# DESCRIPTION #############################################

features <- features.txt : 561 rows, 2 columns
  The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns
  List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt : 2947 rows, 1 column
  Test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 rows, 561 columns
  Recorded features test data
y_test <- test/y_test.txt : 2947 rows, 1 columns
  Test data of activities’code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column
  Train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns
  Recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns
  Train data of activities’code labels

################################################### CODE ####################################################

##Merging the training and the test sets to create one data set.:
Xdata <- rbind(x_train, x_test)
Ydata <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
MergedData <- cbind(Subject, Ydata, Xdata)

################################################# DESCRIPTION #############################################

Xdata (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
Ydata (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
MergedData (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

################################################### CODE ####################################################

##MergedData is our dataset.

##Extracting only the measurements on the mean and 
##standard deviation for each measurement. I used the select
##command to get only the subject and code colummns and also
##the colummns that show the std and mean for each measurement.
CleanData <- select(MergedData, subject, code, contains("mean"), contains("std"))

################################################# DESCRIPTION #############################################

CleanData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the
measurements on the mean and (std) for each measurement

################################################### CODE ####################################################

##Here I used the descriptive activity names, present on the
##activity_labels table, in order to name the activities in the data set:
CleanData$code <- activity_labels[CleanData$code, 2]

################################################# DESCRIPTION #############################################

Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

################################################### CODE ####################################################

##Appropriately labels the data set with descriptive variable names.
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

################################################# DESCRIPTION #############################################

code column in CleanData renamed into Tasks
All Acc in column’s name replaced by Accelerometer
All start with character t in column’s name replaced by Time
All start with character f in column’s name replaced by Frequency
All BodyBody in column’s name replaced by Body
All Gyro in column’s name replaced by Gyroscope
All Mag in column’s name replaced by Magnitude
All angle in column’s name replaced by Angle
All mean in column’s name replaced by Mean
All gravity in column’s name replaced by Gravity
All MeanFreq in column’s name replaced by MeanFrequency

################################################### CODE ####################################################

##From the data set CleanData, now we creates a second, independent 
##tidy data set with the average of each variable for each activity 
##and each subject.

SecondTidyData <- group_by(CleanData, subject, Tasks) %>%
                  summarise_all(list(mean = mean))    
write.table(SecondTidyData, "SecondTidyData.txt", row.name = FALSE )

SecondTidyData

################################################# DESCRIPTION #############################################

SecondTidyData (180 rows, 88 columns) is created by sumarizing CleanData taking the means of each variable for each activity 
and each subject, after groupped by subject and activity.
Export SecondTidyData into SecondTidyData.txt file.










