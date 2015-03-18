Codebook
=================
The following files are provided:
* test/X_test.txt
* test/subject_test.txt
* test/y_test.txt
* train/X_train.txt
* train/subject_train.txt
* train/y_train.txt
* activity_labels.txt
* features.txt

X_test.txt, X_train.txt : These have 561 columns of activity measurements.  
subject_test.txt, subject_train.txt: These have the subject ID for each row of the data set.  
y_test.txt, y_train.txt: These have the activityCode for each row of the data set.  
activity_labels.txt: Use this to convert the activityCodes to friendly activity labels.  

The Plan
====================
Load up the test files with 561 columns.
Tack on the subject column and tack on the 'activity' column.
Note that the 'activity' column will come from a lookup of the activity label.

Next, clean up the labels by swapping the 't' for 'time'.
Swap the 'f' for 'Fourier' and remove the extra '.' characters.
That will make the labels more readable.

Data Field Descriptions
====================
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

* These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation

In addition, we added a unique identifier for each subject and we listed an activity.
* subject
* activity
* The possible values for activity are:
 * WALKING
 * WALKING_UPSTAIRS
 * WALKING_DOWNSTAIRS
 * SITTING
 * STANDING
 * LAYING

Final Tidy Data Set Layout:
Value: Average of all the numbers in the working data set for the subject in one activity.
* Activity: one of these:
 * WALKING
 * WALKING_UPSTAIRS
 * WALKING_DOWNSTAIRS
 * SITTING
 * STANDING
 * LAYING
