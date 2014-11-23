# Codebook of "Getting and Cleaning Data"

<br>

<br>

### Introduction
This is the codebook of the tidy dataset delivered for the Coursera project "Getting and Cleaning Data". The Coursera <a href=https://www.coursera.org/>[1]</a> project is lectured by the John Hopkins Bloomberg School of Public Health <a href=http://www.jhsph.edu/>[2]</a>.
The data is derived from data collected from the accelerometers from Samsung Galaxy S smartphones. The codebook describes
<ul>
* the variables,
* information about the data,
* the transformations performed to clean up the data, to obtain the tidy dataset.
</ul>

A number of hints are taken from David Hood's Project FAQ <a href=https://class.coursera.org/getdata-009/forum/thread?thread_id=58>[3]</a>.

<br>

### Intermezzo: Tidy data
A dataset is tidy if, and only if
<a href=http://www.jstatsoft.org/v59/i10/paper>[4]</a>,
<a href=https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/01_03_componentsOfTidyData.pdf>[5]</a>:
<ul>
* each variable forms a column,
* each observation forms a row,
* each type of observational unit forms a table, and
* the tables can be linked by colums in each table.
</ul>

The result data set is tidy.

<br>

### Datasource
The raw data is:
<a href=https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>.

This raw data is described in
<ul>
* <a href=http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</a>.
* the file "features_info.txt" in the raw data zip file
* the file "README.txt" in the raw data zip file
</ul>

The tidy dataset is obtained by running "run_analysis.R" in R on the raw dataset.
See the README file for details.

<br>

### The transformations
The transformation from the raw dataset into the tidy dataset is as follows:

1. Merge the training and test-sets.
The rows of the test data are appended to the rows of the training data. This is done for the following sets:
<ul>
* X_train and X_test
* subject_train and subject_test
* y_train and y_test
</ul>
The data "X", "subject" and "y" are then column-binded.

<br>

2. Only the measurements on the mean and standard deviation for each measurement are retained.
This is done by only selecting the columns with names containing "mean()"" or "std()" (including the brackets).

3. The activities, denoted by an integer between 1 and 6, have been replaced with their corresponding descriptive name, like "STANDING" or "WALKING". The mapping from number to descriptive name is taken from the file "activity_labels.txt".

4. Meaningful descriptive column names, found in the second column of the file "features.txt", were added to the dataset. In the run_analysis.R implementation, this is done before step 2. As most descriptions contain a minus-sign ("-"), and this can cause problems when using the variable-name in further usage in R, each minus-sign is replaced by an underscore ("_"). For the same reason the brackets in the names have been deleted.

5. From the data set in step 4 a second, independent tidy data set with the average of each variable for each activity and each subject have been created. This file is in de github repository, with name "Result_data.txt". The file has 68 columns, each representing one feature. The features are described in detail in the next paragraph.

<br>

### Variables in the resulting tidy data set
The tidy result data set "Result_data.txt" has 68 variables which are stored in wide format. So, the file has 68 columns.

Each row represents the mean of the raw observations of a specific person and a specific activity.
Each row is regarded as one, new, observation, which is obtained by taking the mean of the corresponding rows from the raw data.
As each row is considered one, new, observation, the data set is tidy from row point of view.
Also, each column represents exactly one feature.
And, the table as a whole represents one observational unit.
So, the resultating data set is tidy.

The 68 variables in the data set are:
<ul>
* the subject: the person who performed the activity, represented by a number between 1 and 30,
* the activity: one of six activities, described as text,
* 66 features as described below, with values are means of the corresponding rows in the raw data set.
</ul>

The 66 variables are the features from the raw dataset which denote the mean and standard deviation of the measured variables. The selection is made in the earlier described step 2. So, in the result data set, the means of means and the means of standard deviations are given.

In the raw data set, all features were already normalized and bounded within [-1,1].
This was done by the process that created the raw dataset. That process is out of scope of this run_analysis.R program. However, it is worthwile to note this step, as it delivers negative standard deviations. Which  would cause someone to frown its eyesbrows.
There are negative standard deviations in the raw data. Which is a result of normalizing and mapping data from a bounded positive domain, say [S1,S2], where S1 and S2 are both positive, to the domain [-1,1]. So, this is what is to be expected.

The description below is for a large part a copy of the file features_info.txt which is part of the dataset <a href=https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>. For matter of completeness, this information is also included in this codebook.

QUOTE from features_info.txt:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals, producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. Note the prefix 'f' to indicate frequency domain signals. 

These signals were used to estimate variables of the feature vector for each pattern, where '-XYZ' is used to denote 3 features, namely the X, Y and Z directions of the 3-axial signal. The dataset "data_5.txt" gives the means and standard deviatons (denoted by a postfix of _mean respectivily _std) of the following signals:
<ul>
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
</ul>

END QUOTE from features_info.txt

<br>

### References
<ol>
1. <a href=https://www.coursera.org/>https://www.coursera.org/</a>
2. <a href=http://www.jhsph.edu/>John Hopkins Bloomberg School of Public Health</a>
3. <a href=https://class.coursera.org/getdata-009/forum/thread?thread_id=58>David Hood, Project FAQ, on Coursera</a>
4. <a href=http://www.jstatsoft.org/v59/i10/paper>Hadley Wickham, "Tidy Data", Journal of Statistical Software, August 2014, Volume 59, Issue 10, http://www.jstatsoft.org/</a>
5. <a href=https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/01_03_componentsOfTidyData.pdf>Coursera Lecture on Tidy Data</a>

</ol>
