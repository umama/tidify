##Package required: reshape2
##Working directory: "UCI HAR Dataset"

##The resultant 'tidy data' is of 'wide' form.

##Any variable containg data from both test and train sets would have the train
#data as the first 70% observations, followed by the test data.

##Read training set test sets and merge them into one variable

train_data <- read.csv("train/X_train.txt", sep = "", header = F)
test_data <- read.csv("test/X_test.txt", sep = "", header = F)
data <- rbind(train_data, test_data)
rm(test_data, train_data)


##Label the data with descriptive variable names provided in features.txt

var_name <- read.csv("features.txt", header = F, sep = "")
names(data) <- var_name[,2]


##Select only the columns corresponding to mean or standard deviation.
##Note: variables calculating mean of frequency are also selected.

ok <- grepl("mean()|std()", names(data), ignore.case = F)
data <- data[, ok]


##Read in the subjects corresponding to each row of the training and test sets.
##Merge the data into one variable.

subj_test <- read.csv("test/subject_test.txt", header = F)
subj_train <- read.csv("train/subject_train.txt", header = F)
subject <- rbind(subj_train, subj_test)
rm(subj_train, subj_test)


##Read in the activity labels from each row of test and train sets.
##Merge them to create one variable containing all activity labels.

act_train <- read.csv("train/y_train.txt", header = F)
act_test <- read.csv("test/y_test.txt", header = F)
activity <- rbind(act_train, act_test)
rm(act_train, act_test)


##Name of each activity, numbered 1 to 6 in 'activity' variable.

act_names <- read.csv("activity_labels.txt", sep = "", header = F)
names(act_names) <- c("number", "name")
act_names$name <- as.character(act_names$name)


##Edit activity variable to contain descriptive activity names (from act_names)
#corresponding to each activity number.

for(i in seq(along = activity[,1])) {
    j <- activity[i, 1]
    activity[i, 2] <- act_names$name[j]
}


##Include subject and activity info in the data set

data <- cbind(subject, activity[,2], data)
names(data)[1:2] <- c("subject", "activity")


##Reshape the dataset by grouping it for distinct (subject, activity) pairs.
##Calculate mean of all variables for each such pair.

n = ncol(data)
reshape <- melt(data, id = c("subject", "activity"), measure.vars = 3:n)
tidy_data <- dcast(reshape, subject + activity ~ variable, mean)

write.table(tidy_data, file = "tidy.txt", row.names = F)