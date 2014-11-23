# Project "Coursera Getting and Cleaning Data"
# very helpful: https://class.coursera.org/getdata-009/forum/thread?thread_id=58#comment-369

# rm(X,X_test,X_train,activity_names,data,data_4,data_5,feature_names_clean,features,selection,subject,subject_test,subject_train,y,y_test,y_train)

# Prerequisites:
# - an existing directory named "UCI HAR Dataset", with a train and test dataset.
# - package "dplyr" is installed

print("Read raw input files")

# Load the training and test files.
# separator = "", which meaning one or more whitespaces.
X_train       <- read.table("./UCI HAR Dataset/train/X_train.txt",       header=FALSE, sep="", dec=".")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="", dec=".")
y_train       <- read.table("./UCI HAR Dataset/train/y_train.txt",       header=FALSE, sep="", dec=".")
X_test        <- read.table("./UCI HAR Dataset/test/X_test.txt",         header=FALSE, sep="", dec=".")
subject_test  <- read.table("./UCI HAR Dataset/test/subject_test.txt",   header=FALSE, sep="", dec=".")
y_test        <- read.table("./UCI HAR Dataset/test/y_test.txt",         header=FALSE, sep="", dec=".")

# Step 1: Merge the training and the test sets to create one data set.
print("Merge data")

# rowbind the training and test-sets
X       <- rbind(X_train, X_test)
subject <- rbind(subject_train, subject_test)
y       <- rbind(y_train, y_test)

# Just a quick smoke test whether the rowbinding went well.
# Add all values in the tables. When the sums add, it is likely OK.
# Note that for adding reals, we must account for imprecision
if ( abs(sum(X) - sum(X_train) - sum(X_test)) > 1e-6 )                   { warning("X is not merged correctly.") }
if ( abs(sum(subject) - sum(subject_train) - sum(subject_test)) > 1e-6 ) { warning("subject is not merged correctly.") }
if ( abs(sum(y) - sum(y_train) - sum(y_test)) > 1e-6 )                   { warning("y is not merged correctly.") }

# columnbind the 3 sets
data <- cbind(X, subject, y)

print("Add feature names")
# Step 2: Extract only the measurements on the mean and standard deviation for each measurement. 
# So, we must know what each column represents
# For that, read the feature-names of file X
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, stringsAsFactors=FALSE)

# Create a vector with cleaned feature names
# Replace all minus-signs in the feature-names with an underscore
feature_names_clean <- gsub(pattern="-", replace="_", x=features[,2])
# Delete all opening and closing brackets
feature_names_clean <- gsub(pattern="[\\(\\)]", replace="", x=feature_names_clean)

# Now we have the names of the colums of X
# Step 4: Appropriately label the data set with descriptive variable names. Don't forget subject and y.
# As "features" has the first variable-name in row 1, the second in row 2 and so on, this is easy.
names(data) <- c(feature_names_clean, "subject", "activity_nr")

# The number of rows of "features" must be equal to the number of colums of "X". Check.
if ( nrow(features) != ncol(X) ) {
  stop("number of rows of 'features.txt' is unequal to number of colums of 'X'")
}

print("Select only features about means and standard deviations")
# Find which columns (these are rows in "features"!) contain the mean and standard deviations.
# These can be selected with "mean()" or "std()".
selection <- grepl("mean\\(\\)|std\\(\\)", features$V2)
# To keep the columns "subject" and "activity", expand "selection" with 2 TRUEs
selection <- c(selection, TRUE, TRUE)
# This selection will be used to keep the desired columns

# First check whether the sizes of the 'selection' and 'data' match.
if ( length(selection) != ncol(data) ) { warning("sizes of 'selection' and 'X' are unequal") }

# Select only the features (columns) which have "mean()" of "std()" in their description.
data <- subset(data, select=selection)

print("Replace the numeric activity descriptions with descriptive names")
# Step 3: Uses descriptive activity names to name the activities in the data set

# Read the descriptive activity names
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)

# Give this table column names
names(activity_names) <- c("activity_nr", "activity")

# Merge the large data table with the activity-description, match on "activity_nr"
data_4 <- merge(x=data, y=activity_names, by="activity_nr", all.x=TRUE)

# Drop the column 'activity_nr' to make the data set tidy again
data_4 <- data_4[,!(names(data_4) == "activity_nr")]

# As Step 4 was already executed earlier, data_4 is the dataset obtained after the first 4 steps

print("Take mean of each variabele in dataset")
# Step 5: From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
library(dplyr, verbose=FALSE, quiet=TRUE)
data_5 <- data_4 %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

# A very small unit-test, checked against https://class.coursera.org/getdata-009/forum/thread?thread_id=183
if ( abs(as.matrix(data_5 %>% filter(subject==1, activity=="WALKING") %>% select(tBodyAccMag_mean))[,2] + 0.136971176556842) < 1e-6 ) {
  print("Unit test OK")
} else {
  warning("A test of one value has unexpected value. Something wrong?")
}

print("Write output data")
# Write output data
write.table(x=data_5, file="Result_data.txt", row.names=FALSE, col.names=TRUE)
