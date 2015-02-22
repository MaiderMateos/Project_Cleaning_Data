
# Load the required libraries
library(dplyr)

# Read the train data
xtrain <- read.table("X_train.txt", header=F)
ytrain <- read.table("y_train.txt", header=F, col.names="activity")
subject_train <- read.table("subject_train.txt", header=F, col.names="id")

# Read the test data
xtest <- read.table("X_test.txt", header=F)
ytest <- read.table("y_test.txt", header=F, col.names="activity")
subject_test <- read.table("subject_test.txt", header=F, col.names="id")

# Read variable (feature) names
feature <- read.table("features.txt", header=F)

# Read activity labels
activity <- read.table("activity_labels.txt")

# 'subject' dataframes have only one variable. It corresponds to subject id.
# 'subject_train' has 21 different values and 'subject_test' has 9 values.
# 'y' dataframes contain one variables that takes integer values from 1 to 6
# This values correspond to the 6 different activities each subject does
# 'x' dataframes contain the 561 variables (features) measured

# First, we create two dataframes with all the train and test data, respectively
# We can do it by column binding
train <- cbind(subject_train, ytrain, xtrain)
test <- cbind(subject_test, ytest, xtest)

# Now, we put data from both groups together by row binding
data <- rbind(train, test)
# Change the column names
colnames(data) <- c("id", "activity", as.character(feature$V2))
# Both id and activity should be factors
data$id <- factor(data$id)
data$activity <- factor(data$activity)

# Look for the columns containing the means or standard deviations
# We don't take into account the variables about mean frequencies
var_selection <- union(setdiff(grep("mean()", colnames(data)), grep("Freq",colnames(data))),
                       grep("std()", colnames(data)))
var_selection <- sort(var_selection)

# Keep only the variables about means or standard deviations
data <- data[,c(1,2,var_selection)]

# Label the activities with appropriate names. 
# Be careful with the order of the levels
levels(data$activity) <- reorder(activity$V2, activity$V1)

# In order to make variable names more readable we remove the parenthesis
colnames(data) <- gsub("[:():]", "", colnames(data))
# And the hyphens
colnames(data) <- gsub("-", ".", colnames(data))
# Change BodyBody to Body
colnames(data) <- gsub("BodyBody", "Body", colnames(data))
# Make initial t and f meaningful
colnames(data) <- sub("^t", "time", colnames(data))
colnames(data) <- sub("^f", "freq", colnames(data))

# Create the data set for submission
to_submit <- summarise_each(group_by(data, id, activity), funs(mean))

# For all the columns to be printed
options(dplyr.width=Inf)

to_submit

