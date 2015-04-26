# tidify
#README for course project, Getting and Cleaning Data

Data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

30 subjects, with a smartphone attached to their waist, performed 6 activities. Data was collected using the smartphone's built-in accelerometer and gyrometer. This data was then separated into training (70%) and test sets. Features were calculated using this collected data.

This repo consists of the following:
1. run_analysis.R, containing the code for performing the required editing.
2. README.md, explaining the analysis used in the R script.
3. codebook, containing a description of the feature variables.

For run_analysis.R:

Package required: reshape2
Working directory: "UCI HAR Dataset"

The resultant 'tidy data' is of 'wide' form, i.e. each row of tidy data contains the means of each of the feature variables for that row's (subject, activity) pair.

Any variable containg data from both test and train sets would have the train data as the first 70% observations, followed by the test data.

Read training set test sets and merge them into one variable

Label the data with descriptive variable names provided in features.txt

Select only the columns corresponding to mean or standard deviation.
Note: variables calculating mean of frequency are also selected.

Read in the subjects corresponding to each row of the training and test sets.
Merge the data into one variable.

Read in the activity labels from each row of test and train sets.
Merge them to create one variable containing all activity labels.

Name of each activity, numbered 1 to 6 in 'activity' variable.

Edit activity variable to contain descriptive activity names (from act_names) corresponding to each activity number.

Include subject and activity info in the data set

Reshape the dataset by grouping it for distinct (subject, activity) pairs.
Calculate mean of all variables for each such pair.
This completes the project's requirements.

Save the 'tidy' data into a .txt file using write.table().
