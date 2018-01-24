## Include necessary libraries
library(dplyr)

## Load in the data from files into data frames with descriptive names
features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")

## Change "y" dataframes to be factor variables, containing descriptive factor levels, 
## corresponding the activity dataframe
yfactors <- setNames(as.character(activity$V2), activity$V1)
ytest_factorial <- unname(yfactors[as.character(ytest$V1)])
ytrain_factorial <- unname(yfactors[as.character(ytrain$V1)])

## Include a column with the subject IDs as first column and a column with the current activity
xtest <- cbind(subject_test, ytest_factorial, xtest)
xtrain <- cbind(subject_train, ytrain_factorial, xtrain)

## Give every column an appropriate and descriptive name according to the included ReadMe.txt
names(xtest) <- c("ID", "activity", as.character(features$V2))
names(xtrain) <- c("ID", "activity", as.character(features$V2))

## Combine training data and test data into one "total" dataset
total <- rbind(xtest, xtrain)

## Extract only the mean and standard deviation measurements from the data
select_total <- total[, grepl("^ID$|^activity$|mean[^F]|std()", names(total))]

## Compute the average of each variable for each activity and each subject and sort by ID and activity
tidy_set <- group_by(select_total, ID, activity) %>%
        summarise_all(mean) %>%
        arrange(ID, activity)

## Write the new, tidy dataset to a textfile, called "tidy_data.txt"
write.table(tidy_set, "tidy_data.txt", row.names = F)

