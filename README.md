# Cleaning-Data-Assignment
The merging and data cleaning of two sets of accelerometer data recorded from a wearable fitness device.

## Overview
This project and R script, merges, cleans and summarise data from the Human Activity Recognition Using Smartphones Data Set[1] at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Description of files 
### Raw Data (./data/raw data/)
The raw data input required (downloaded from the site) is located in the **./data/raw data** directory

### Output files (./data/)
Interim and output data files are located in the **./data/** directory

**merged.csv** - An interim table containing the merge of raw test and training data with the feature headings as table variables
**clean.csv** -  An interim table of the merged data from the merged.csv file but now contains subject and activity variables.

**tidy_mean_output.txt** - **This output is the end result of the analysis**

### R script files (./)
**main.R** - A start stub that runs the data cleaning script "run_analysis.R"

**run_analysis.R** - this is the repeatable script to clean the raw data and produce the tidy output data.

### Other files (./data/)
**Codebook.md (./data/Codebook.md)** - contains table information on the tidy_mean_output.txt output format

**tidy_mean_output.cvs** - This output is the end result of the analysis in csv format

**variables.csv** - A listing of the table variables - good for updating the codebook

## How to run the script
Update the main.R code to your local environment directory setting and run.

source(run_analysis.R) in your custom code and call the function **run_analysis.R**

## The data cleaning approach
This is a description of how the run_analysis() function takes the raw data and create the final tidy output.

For further details, refer to the code comments.

1. Read the test and training data and merge the two tables
+ These are large fixed width files
+ fread() (fast read) was used to read in the large files
+ each line was then split to a fixed width and read into a target data table
+ merging was achieved by appending the second files records into the target data table

2. Variable names were read from the Features.txt file

3. An interim csv files was written to disk.
+ **merged.csv** - An interim table containing the merge of raw test and training data with the feature headings as table variables
+ The reason for the interim step was to preserve a significant checkpoint in data cleaning process
+ The initial step of reading and merging the raw data took several minutes
+ Saving the output of the process, served as a shortcut to the next step of developing later stages of the script

4. Read in the activity and volunteer (subject) information

5. Create the final table with volunteer, activity, measurement data

6. Aggregate the average of each variable for each activity and each subject.

7. Write the output **tidy_mean_output.txt** - **This output is the end result of the analysis**










