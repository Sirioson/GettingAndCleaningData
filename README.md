GettingAndCleaningData
======================

<br>

<br>

## Prerequisites

#### 1. UCI HAR Dataset
Prerequisite for running the analysis is an (unzipped) directory "UCI HAR Dataset" in the current working directory.
This directory should be an unmodified version of unzipping the following file:
<a href=https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>

If you don't have that directory, you can get it with the R program
```
source("get_data_from_web.R")
```
This program makes a temporary directory, downloads the data from internet, unzips it to the current working directory, and last cleans the temporary directory.

The speed at which this is executed depends on the speed of the (end-to-end) internet connection.

#### 2. package "dplyr"
Prerequisite is the "dplyr" package.
If it is not installed yet, install it with
```
install.packages("dplyr")
```

<br>

## Run analysis

The data analysis can be executed with
```
source("run_analysis.R")
```
It functional working is described the codebook.
It creates a file "Result_data.txt" in the current working directory.

If desired, this file can be read in R with
```
datacheck <- read.table("Result_data.txt", header=TRUE)
```

The execution speed depends on the hardware used. Expect it to run for some 30 seconds on a typical PC.
Most of the time is in the step of reading the data from the input file.
