# How the run_analysis.R script works

Remember that Samsung data must be in the working directory.
Specifically, the files that should be in the working directory are:
* X_train.txt
* y_train.txt
* subject_train.txt
* X_test.txt
* y_test.txt
* subject_test.txt
* features.txt
* activity_labels.txt

The first thing the script does is loading the packages thas will be used. In this case, only the "dplyr" package is required.

Then, all the files are read with the read.table() command.

By means of the cbind() function, two data frames are created, one containing all the data of the "train" group and the other containing the data of the "test" group.

Both data sets are merged together using the rbind() instruction. Now we have a unique data set with all the subjects and all the measurements, but we are interested only in the variables that represent the mean and the standard deviation of each measurement. Hence, grep() function is used to keep only those variables containing the expressions "mean()" and "std()" in their names. The variables related to mean frequencies are also removed. After this step 68 variables are kept.



