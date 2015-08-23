install.packages("data.table")
install.packages("dplyr")
install.packages("stringr")

library("data.table")
library("dplyr")
library("stringr")

# setwd("~/Code/R/Cleaning-Data-Assignment")

## The run_analysis function cleans and summarises data from the 
## Human Activity Recognition Using Smartphones Data Set at
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## The output of this scipt contains two interim output files and the final tidy summary data
## The files are produced in the following order as the data is transformed from raw to tidy data
##
## 1. merged.csv -  An interim table containing the merge of test and training data 
##                  with feature headings
## 2. clean.csv -   An interim table of the merged data from the merged.csv file but now contains
##                  subject and activity variables. The remaining measurement variables
##                  have been changed to a more readable format
## 3. tidy_mean_output.txt -    This output is the end result of the analysis
##
##
## Other files that are produces are:
## 4. variables.csv -   A list of the variable names used in the output. This is useful
##                      for writing the codebook
## 5. tidy_mean_output.cvs  - this file is the same as tidy_mean_output.txt, but in csv format
##

run_analysis <- function() {

    print("Data Cleaning in process.  This may take about 5 minutes...")

    # The raw data files are fixed width fields and large! 
    # fread() enables fast read time for large files, but does not handle fixed width files

    # Fast Read in each line of the files
    Train <- fread("./data/raw data/train/X_train.txt", header = FALSE, sep= "\n", stringsAsFactors = FALSE)
    Test <- fread("./data/raw data/test/X_test.txt", header = FALSE, sep= "\n", stringsAsFactors = FALSE)
    
    # Create an empty target data table 
    AT <- data.table()
    
    # Number of lines to to read in the training file
    len <- length(Train[, V1])
    
    # Now split each line of the training data table in add to the target data.table
    for ( i in 1:len) {
       v <- sapply( strsplit(Train[i, V1], "\\s+"), function(x) {as.numeric(x) })
       v <- v[-1]  # Remove the NA created by the leading whitespace
       # t <- data.table(t(v))
       AT <- rbind(AT, as.data.table(t(v)))
    }
    
    # Number of lines to to read in the test file
    len <- length(Test[, V1])

    # continue reading and splitting test file rows into the target data.table
    for ( i in 1:len) {
        v <- sapply( strsplit(Test[i, V1], "\\s+"), function(x) {as.numeric(x) })
        v <- v[-1]  # Remove the NA created by the leading whitespace
        AT <- rbind(AT, as.data.table(t(v)))
    }
    
    #  Read the column names of the raw data from the features file
    Features <- read.table("./data/raw data/features.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)

    #  Write back as an interim merged file
    #  This was done to save time when testing the latter parts of the data clean
    #  
    write.table(AT, "./data/merged.csv", sep = ",", row.names = FALSE, col.names = Features[,2])
 
    # Test read back in
    interim_file <- fread("./data/merged.csv", header = TRUE, sep= ",", stringsAsFactors = FALSE)
   
    ## Read in the file data to construct the id variables "subject" & "activity"
    Activity_Labels <- read.table("./data/raw data/activity_labels.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
    subject_train <- read.table("./data/raw data/train/subject_train.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
    subject_test <- read.table("./data/raw data/test/subject_test.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
    y_train <- read.table("./data/raw data/train/y_train.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
    y_test <- read.table("./data/raw data/test/y_test.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
    
    ## Create the new id columns
    subject <- rbind(subject_train, subject_test)
    activities <- rbind(y_train, y_test)
    activities <- merge(activities, Activity_Labels)
    subject <- rename(subject, volunteer = V1)
    activities <- rename(activities, activities = V2)
    
    interim_file <- select(interim_file, grep("mean()", names(interim_file)), grep("std()", names(interim_file)) )
    interim_file <- cbind(select(activities, activities), interim_file)
    interim_file <- cbind(subject, interim_file)
    
    
    ## Make the variable names more readable
    ## note on gsub() - brackets are required for the back reference
    colnames <- gsub( "([A-Z])",  " \\1" , names(interim_file))
    colnames <- gsub( "-",  " " , colnames)
    colnames <- sub( "^f", "freq ", colnames)
    colnames <- sub( "^t", "time" , colnames)
    colnames <- gsub( "\\ +", " " , colnames)
    colnames <- tolower(colnames)
    
    #  Write the column names for the codebook
    write.table(colnames, "./data/variables.csv", sep = ",", row.names = FALSE, col.names=FALSE)

    setnames(interim_file, old = 1:81, new = colnames)
    
    #  write back the clean result
    write.table(interim_file, "./data/clean.csv", sep = ",", row.names = FALSE)
    
    tidy_mean <- aggregate(interim_file[, -(1:2)], list(interim_file$activities, interim_file$volunteer), mean)
   
    # fix names created by the aggregate function 
    tidy_mean <- rename(tidy_mean, volunteer = Group.2)
    tidy_mean <- rename(tidy_mean, activity = Group.1)

    # order by table
    tidy_mean <- tidy_mean[order(tidy_mean$activity), ]

    
    write.table(tidy_mean, file = "./data/tidy_mean_output.txt", row.names = FALSE)
    
    # write the same data as a csv... as I find this an easier format to work with
    write.table(tidy_mean, file = "./data/tidy_mean_output.csv", sep = ',', row.names = FALSE)

    
    # Some test code I used to confirm results seen in the tidy_mean table

    # test <- select(tidy_mean, subject, activities)
    # table(test)

}
