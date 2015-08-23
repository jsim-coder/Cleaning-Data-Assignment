install.packages("data.table")
install.packages("dplyr")
install.packages("stringr")
# install.packages("mvbutils")
# install.packages("sss")

library("data.table")
library("dplyr")
library("stringr")
#library("mvbutils")
#library("sss")

run_analysis <- function() {

# Fast Read in each line of the files
Train <- fread("./data/raw data/train/X_train.txt", header = FALSE, sep= "\n", stringsAsFactors = FALSE)
Test <- fread("./data/raw data/test/X_test.txt", header = FALSE, sep= "\n", stringsAsFactors = FALSE)

# Create an empty target data table 
AT <- data.table()

# Number of lines to to read in the training file
len <- length(Train[, V1])

# This works but is very slow (nothing else seems to be able to handle these files)
# These are large and fixed width.. the worst of both worlds!
for ( i in 1:len) {
   v <- sapply( strsplit(Train[i, V1], "\\s+"), function(x) {as.numeric(x) })
   v <- v[-1]  # Remove the NA created by the leading whitespace
   # t <- data.table(t(v))
   AT <- rbind(AT, as.data.table(t(v)))
}

# Number of lines to to read in the test file
len <- length(Test[, V1])
# Now do the same again and keep adding the test file rows

for ( i in 1:len) {
    v <- sapply( strsplit(Test[i, V1], "\\s+"), function(x) {as.numeric(x) })
    v <- v[-1]  # Remove the NA created by the leading whitespace
    AT <- rbind(AT, as.data.table(t(v)))
}

## Read the column names
Features <- read.table("./data/raw data/features.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)

## Read the column names
Activity_Labels <- read.table("./data/raw data/activity_labels.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)


#  write back as an interim csv
write.table(AT, "./data/interim.csv", sep = ",", row.names = FALSE, col.names = Features[,2])

# Test read back in
interim_file <- fread("./data/interim.csv", header = TRUE, sep= ",", stringsAsFactors = FALSE)

## Read the additional columns
subject_train <- read.table("./data/raw data/train/subject_train.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
subject_test <- read.table("./data/raw data/test/subject_test.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
y_train <- read.table("./data/raw data/train/y_train.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)
y_test <- read.table("./data/raw data/test/y_test.txt", header = FALSE, sep= " ", stringsAsFactors = FALSE)


#Create the new columns
subject <- rbind(subject_train, subject_test)


activities <- rbind(y_train, y_test)
activities <- merge(activities, Activity_Labels)

subject <- rename(subject, subject = V1)
activities <- rename(activities, activities = V2)

b <- select(Step1, grep("mean()", names(interim_file)), grep("std()", names(interim_file)) )
b <- cbind(select(activities, activities), b)
b <- cbind(subject, b)


## Now cleanup the  column names
## it seems you need the brackets for the back reference
colnames <- gsub( "([A-Z])",  " \\1" , names(b))
colnames <- gsub( "-",  " " , colnames)
colnames <- sub( "^f", "freq ", colnames)
colnames <- sub( "^t", "time" , colnames)
colnames <- gsub( "\\ +", " " , colnames)
colnames <- tolower(colnames)

## sets all the column names
setnames(b, old = 1:81, new = colnames)

## B is now our final result
## library(plyr)
## ddply(b, .(subject, activities), mean)


# x <- tapply(b, list(b$subject, b$activities), mean)

x <- aggregate(b[, -(1:2)], list(b$activities, b$subject), mean)

# order by 
write.table(x, file = "./data/interim.txt", row.names = FALSE)

# Confirm results
# test <- select(b, subject, activities)
# table(test)

}
