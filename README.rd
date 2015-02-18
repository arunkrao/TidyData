Part A: The implementation in run_analysis.R which gets us from raw data to tidy data

A summary of steps that were followed is listed here; please also see comments in the code itself for additional details.
1. First read the names of all the features (= measurement variables) from features.txt.These names (or their derivations) will need to become column names in our dataset. 
2. Due to implementation constraints (associated with summarize (that at least I could not get around)), all special characters in feature names (including "(", ")", "-" and ",") are replaced with the underscore character ("_"). This does not create any conflicts, since I verified that the column names are still unique and distinguishable from each other.
3. Read in the test and train data files into data frames, and add the column names to the data frames (collected in steps 1 and 2).
4. We only need the columns containing the mean and the standard deviation measurements. These are assumed to be all measurement variables which have either the string "mean" or the string "std" embedded in their names. Find the list of such columns.
5. Subset the test and train data frames so as to contain only the columns we need (identified in step 4).
6. Next, read the set of subjects (numbered 1 to 30) and activities (numbers corresponding to WALKING, SITTING etc) for each of test and train data sets and add them as new columns to the test and train data frames.
7. The test and train data frames now have all the data we need. Combine them into a single data frame using rbind.
8. Replace the activity id in the combined data frame with the activity name. The names of each activity are read from an available data file. 
9. Change activity and subject from characters to factors in the combined data set and group by these two fields.
10. For each of the columns representing features in the combined data set, find the mean by activity and by subject. Create this as a new data frame (comprising columns  Subject, Activity, Feature variable, Average). Loop through and append to this new data frame for each variable in the combined data frame. 
11. We now have the final tidy data frame.


Part B: The code book describing the tidy data set
The tidy data set has 4 columns named:
Subject: This is the subject id for the test participants in the study. Since there were 30 participants, this ranges from 1 to 30.
Activity: This is one of the defined activities during which measurements were taken; is one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING & LAYING. 
average: This is the mean value of the measurement variable for a specific subject, specific activity and measurement variable.
Variable: This is a subset of the variables in the raw data; only those variables which have been interpreted as "mean" or "std" measurements are included, all the rest from the raw data are excluded. The variable names in the tidy data set have also gone through a transformation from the raw data set, wherein special characters have been replaced with underscore ("_") for implementation reasons. Nevertheless, there is a one-to-one mapping between tidy variable names and their corresponding raw variable names. 

The tidy variable names (stored in the Variable column listed above) in the final tidy data set are as follows:
 [1] "tBodyAcc_mean___X"               "tBodyAcc_mean___Y"              
 [3] "tBodyAcc_mean___Z"               "tGravityAcc_mean___X"           
 [5] "tGravityAcc_mean___Y"            "tGravityAcc_mean___Z"           
 [7] "tBodyAccJerk_mean___X"           "tBodyAccJerk_mean___Y"          
 [9] "tBodyAccJerk_mean___Z"           "tBodyGyro_mean___X"             
[11] "tBodyGyro_mean___Y"              "tBodyGyro_mean___Z"             
[13] "tBodyGyroJerk_mean___X"          "tBodyGyroJerk_mean___Y"         
[15] "tBodyGyroJerk_mean___Z"          "tBodyAccMag_mean__"             
[17] "tGravityAccMag_mean__"           "tBodyAccJerkMag_mean__"         
[19] "tBodyGyroMag_mean__"             "tBodyGyroJerkMag_mean__"        
[21] "fBodyAcc_mean___X"               "fBodyAcc_mean___Y"              
[23] "fBodyAcc_mean___Z"               "fBodyAcc_meanFreq___X"          
[25] "fBodyAcc_meanFreq___Y"           "fBodyAcc_meanFreq___Z"          
[27] "fBodyAccJerk_mean___X"           "fBodyAccJerk_mean___Y"          
[29] "fBodyAccJerk_mean___Z"           "fBodyAccJerk_meanFreq___X"      
[31] "fBodyAccJerk_meanFreq___Y"       "fBodyAccJerk_meanFreq___Z"      
[33] "fBodyGyro_mean___X"              "fBodyGyro_mean___Y"             
[35] "fBodyGyro_mean___Z"              "fBodyGyro_meanFreq___X"         
[37] "fBodyGyro_meanFreq___Y"          "fBodyGyro_meanFreq___Z"         
[39] "fBodyAccMag_mean__"              "fBodyAccMag_meanFreq__"         
[41] "fBodyBodyAccJerkMag_mean__"      "fBodyBodyAccJerkMag_meanFreq__" 
[43] "fBodyBodyGyroMag_mean__"         "fBodyBodyGyroMag_meanFreq__"    
[45] "fBodyBodyGyroJerkMag_mean__"     "fBodyBodyGyroJerkMag_meanFreq__"
[47] "tBodyAcc_std___X"                "tBodyAcc_std___Y"               
[49] "tBodyAcc_std___Z"                "tGravityAcc_std___X"            
[51] "tGravityAcc_std___Y"             "tGravityAcc_std___Z"            
[53] "tBodyAccJerk_std___X"            "tBodyAccJerk_std___Y"           
[55] "tBodyAccJerk_std___Z"            "tBodyGyro_std___X"              
[57] "tBodyGyro_std___Y"               "tBodyGyro_std___Z"              
[59] "tBodyGyroJerk_std___X"           "tBodyGyroJerk_std___Y"          
[61] "tBodyGyroJerk_std___Z"           "tBodyAccMag_std__"              
[63] "tGravityAccMag_std__"            "tBodyAccJerkMag_std__"          
[65] "tBodyGyroMag_std__"              "tBodyGyroJerkMag_std__"         
[67] "fBodyAcc_std___X"                "fBodyAcc_std___Y"               
[69] "fBodyAcc_std___Z"                "fBodyAccJerk_std___X"           
[71] "fBodyAccJerk_std___Y"            "fBodyAccJerk_std___Z"           
[73] "fBodyGyro_std___X"               "fBodyGyro_std___Y"              
[75] "fBodyGyro_std___Z"               "fBodyAccMag_std__"              
[77] "fBodyBodyAccJerkMag_std__"       "fBodyBodyGyroMag_std__"         
[79] "fBodyBodyGyroJerkMag_std__"   

The corresponding feature names (in the same order) in the raw data files are:
 [1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"              
 [3] "tBodyAcc-mean()-Z"               "tGravityAcc-mean()-X"           
 [5] "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"           
 [7] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"          
 [9] "tBodyAccJerk-mean()-Z"           "tBodyGyro-mean()-X"             
[11] "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"             
[13] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"         
[15] "tBodyGyroJerk-mean()-Z"          "tBodyAccMag-mean()"             
[17] "tGravityAccMag-mean()"           "tBodyAccJerkMag-mean()"         
[19] "tBodyGyroMag-mean()"             "tBodyGyroJerkMag-mean()"        
[21] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
[23] "fBodyAcc-mean()-Z"               "fBodyAcc-meanFreq()-X"          
[25] "fBodyAcc-meanFreq()-Y"           "fBodyAcc-meanFreq()-Z"          
[27] "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"          
[29] "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-meanFreq()-X"      
[31] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"      
[33] "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
[35] "fBodyGyro-mean()-Z"              "fBodyGyro-meanFreq()-X"         
[37] "fBodyGyro-meanFreq()-Y"          "fBodyGyro-meanFreq()-Z"         
[39] "fBodyAccMag-mean()"              "fBodyAccMag-meanFreq()"         
[41] "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-meanFreq()" 
[43] "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-meanFreq()"    
[45] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-meanFreq()"
[47] "tBodyAcc-std()-X"                "tBodyAcc-std()-Y"               
[49] "tBodyAcc-std()-Z"                "tGravityAcc-std()-X"            
[51] "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
[53] "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"           
[55] "tBodyAccJerk-std()-Z"            "tBodyGyro-std()-X"              
[57] "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
[59] "tBodyGyroJerk-std()-X"           "tBodyGyroJerk-std()-Y"          
[61] "tBodyGyroJerk-std()-Z"           "tBodyAccMag-std()"              
[63] "tGravityAccMag-std()"            "tBodyAccJerkMag-std()"          
[65] "tBodyGyroMag-std()"              "tBodyGyroJerkMag-std()"         
[67] "fBodyAcc-std()-X"                "fBodyAcc-std()-Y"               
[69] "fBodyAcc-std()-Z"                "fBodyAccJerk-std()-X"           
[71] "fBodyAccJerk-std()-Y"            "fBodyAccJerk-std()-Z"           
[73] "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"              
[75] "fBodyGyro-std()-Z"               "fBodyAccMag-std()"              
[77] "fBodyBodyAccJerkMag-std()"       "fBodyBodyGyroMag-std()"         
[79] "fBodyBodyGyroJerkMag-std()"

#####################################################################################################################
Original readme for the raw data included below
#####################################################################################################################
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

