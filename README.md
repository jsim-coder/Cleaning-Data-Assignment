# Cleaning-Data-Assignment
The merging and data cleaning of two sets of accelerometer data recorded from a wearable fitness device.


## Overview
This project and R script, merges cleans and summarise data from the 
Human Activity Recognition Using Smartphones Data Set at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Description of files 
### Raw Data
The raw data input required (downloaded from the site) is located in the "./data/raw data" directory

### Output files
Interim and output data files are located in the "./data/" directory

merged.csv - An interim table containing the merge of raw test and training data with the feature headings as table variables
clean.csv -  An interim table of the merged data from the merged.csv file but now contains subject and activity variables. 
tidy_mean_output.txt - This output is the end result of the analysis

### R script files
main.R - A start stub that runs the data cleaning script "run_analysis.R"
run_analysis.R - this is the repeatable script to clean the raw data and produce the tidy output data.

### Other files
"./data/codebook.md contains table information on the tidy_mean_output.txt output format

## How to run
Update the main.R code to your local environment directory setting and run.

source(run_analysis.R) in your custom code and call the function run_analysis.R

## The process



