# Cleaning-Data-Assignment - code book  Version 1.0 - 23 August 2015
This document describes the table fields for the tidy_mean_output.txt file

## Overview
The output data file (tidy_mean_output.txt) summarises data from the 
Human Activity Recognition Using Smartphones Data Set at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The raw data codebook is contained in this github project in file the ./data/raw data/README.txt


## Experiment - Background

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# Data Dictionary - tidy_mean_output.txt or tidy_mean_output.csv
Each record contains 2 identification variable and 79 measurement "means".

## ID Variables
volunteer - A number uniquely represents a volunteer that participated in the study
activity - One of the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) measured wearing a smart phone.

## Measurement Variables
The mean value of all measurements taken for each activity for each volunteer in the study.

All values are mean values of each activities' recording for each volunteer.

The values are means of normalise values, ie the value lies between -1 and 1.

time body acc mean() x
time body acc mean() y
time body acc mean() z
time gravity acc mean() x
time gravity acc mean() y
time gravity acc mean() z
time body acc jerk mean() x
time body acc jerk mean() y
time body acc jerk mean() z
time body gyro mean() x
time body gyro mean() y
time body gyro mean() z
time body gyro jerk mean() x
time body gyro jerk mean() y
time body gyro jerk mean() z
time body acc mag mean()
time gravity acc mag mean()
time body acc jerk mag mean()
time body gyro mag mean()
time body gyro jerk mag mean()
freq body acc mean() x
freq body acc mean() y
freq body acc mean() z
freq body acc mean freq() x
freq body acc mean freq() y
freq body acc mean freq() z
freq body acc jerk mean() x
freq body acc jerk mean() y
freq body acc jerk mean() z
freq body acc jerk mean freq() x
freq body acc jerk mean freq() y
freq body acc jerk mean freq() z
freq body gyro mean() x
freq body gyro mean() y
freq body gyro mean() z
freq body gyro mean freq() x
freq body gyro mean freq() y
freq body gyro mean freq() z
freq body acc mag mean()
freq body acc mag mean freq()
freq body body acc jerk mag mean()
freq body body acc jerk mag mean freq()
freq body body gyro mag mean()
freq body body gyro mag mean freq()
freq body body gyro jerk mag mean()
freq body body gyro jerk mag mean freq()
time body acc std() x
time body acc std() y
time body acc std() z
time gravity acc std() x
time gravity acc std() y
time gravity acc std() z
time body acc jerk std() x
time body acc jerk std() y
time body acc jerk std() z
time body gyro std() x
time body gyro std() y
time body gyro std() z
time body gyro jerk std() x
time body gyro jerk std() y
time body gyro jerk std() z
time body acc mag std()
time gravity acc mag std()
time body acc jerk mag std()
time body gyro mag std()
time body gyro jerk mag std()
freq body acc std() x
freq body acc std() y
freq body acc std() z
freq body acc jerk std() x
freq body acc jerk std() y
freq body acc jerk std() z
freq body gyro std() x
freq body gyro std() y
freq body gyro std() z
freq body acc mag std()
freq body body acc jerk mag std()
freq body body gyro mag std()
freq body body gyro jerk mag std()


