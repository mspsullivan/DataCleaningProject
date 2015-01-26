# run_analysis.R
# Course project for getdata-010
# Perform the following on telemetry data:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy 
#  data set with the average of each variable for each activity and each subject.

install.packages("dplyr")
library(dplyr)
# Load a data frame with column names
features <- read.table("UCI HAR Dataset/features.txt")
traind <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2], header = FALSE)
testd <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2], header = FALSE)

# Step 1 merge training and test sets
# use rbind to combine the data frames
# this .15 seconds compared to merge that takes over 21 seconds.
fullDataSet <- rbind(traind, test)
#
# Step 2 extract measurements on the mean and standard deviation
# from the features_info file this should include the following:
# 
# grep the names that include mean() like this grep("mean...", names(fullDataSet), value = TRUE)
# grep the names that include std() like this grep("std", names(fullDataSet), value = TRUE)
# I chose to pull the names from the fullDataSet instead of the 'features' list because the special 
#   characters in the column names get parsed out during the read.table calls and don't match well here.
# join those two lists together and extract the measurements
meanFeatures <- c(grep("mean...", names(fullDataSet), value = TRUE), grep("std", names(fullDataSet), value = TRUE))
#
meanDataSet <- fullDataSet[meanFeatures]
#
# Step 3 Use descriptive activity names
# read the activity names from activity_labels.txt
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
# time due changed from 11:30 to 6:30 ran out of time.
