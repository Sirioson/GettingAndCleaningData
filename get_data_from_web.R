# Downloads the data and unzips it

source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

library(RCurl)

# create a temporarily file
file_zipped <- tempfile()

# download file
download.file(url=source, destfile=file_zipped, method="curl", mode="wb")

# unzip file to the current working directory
unzip(zipfile=file_zipped, exdir=".")

# clean the temporarily file
rm(file_zipped)

# Now we have the directory "UCI HAR Dataset", with a training and test dataset.
