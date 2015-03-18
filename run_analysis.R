# run_analysis.R
# Course project for getdata-010
# Perform the following on telemetry data:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy 
#  data set with the average of each variable for each activity and each subject.
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#install.packages("dplyr")
library(dplyr)
library(plyr)
library(reshape2)

# Load a data frame with column names
features <- read.table("UCI HAR Dataset/features.txt")
traind <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2], header = FALSE)
testd <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2], header = FALSE)

# Step 1 merge training and test sets
# use rbind to combine the data frames
# this .15 seconds compared to merge that takes over 21 seconds.
fullDataSet <- rbind(traind, testd)
#
# Step 2 extract measurements on the mean and standard deviation
# I chose to pull the names from the fullDataSet instead of the 'features' list because the special 
#   characters in the column names get parsed out during the read.table calls and don't match well here.
# join those two lists together and extract the measurements
meanFeatures <- grep("std\\.|mean\\.", names(fullDataSet))
#
meanDataSet <- fullDataSet[meanFeatures]
#
# Step 3 Use descriptive activity names
# read the activity names from activity_labels.txt
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityCode", "activityName"))

# Load the subjects. The column gets the default name V1 so use subject instead
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))

testSubjectActivityCode <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activityCode"))
trainSubjectActivityCode <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activityCode"))
# load up a data frame that has subject, activityName
fullSubjectActivityCode <- rbind(testSubjectActivity, trainSubjectActivity)
fullSubject <- rbind(testSubjects, trainSubjects)
# Get the Activity text by merging the ActivityLabels with the ActivityCodes
#
activity <- activityLabels$activityName[fullSubjectActivityCode[,1]]
# Now tack the two new columns onto the mean data set.
# first, add the subject column, then add the activity column.
#
almostTidyDataSet <- cbind(meanDataSet, fullSubject)
preDataSet <- cbind(almostTidyDataSet, activity)

# Step 4 label the data set with descriptive variable names.
# replace t with time
newNames <- sub("^t", "time", names(preDataSet))
# replace f with fourier (for the Fourier transform applied)
newNames2 <- sub("^f", "fourier", newNames)
# remove ..  
newNames3 <- sub("..", "", newNames2, fixed = TRUE)
names(preDataSet) <- newNames3
# Step 5 average each variable for each activity and each subject. That is the tidy data set.
# This data set should have three columns and be easy to use to cross-check results.
tidyDataSet <- ddply(melt(preDataSet, id.vars=c("subject", "activity")), .(subject, activity), summarize, NewValues = mean(value))
# That's it, write the data set out.
write.table(tidyDataSet, file = "tidyData.txt", col.name = FALSE)

