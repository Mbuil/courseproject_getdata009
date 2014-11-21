This CodeBook contains: 
1) Description of original data
2) Description of variables
3) Steps/transformations made to answer problem 1 through 5
4) Description of cleaned data after problem 1 through 5 using the script run_analysis.R

1) Description of original data
The original datasets was downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original datasets are divided into training group and test group, each containing 3 separate datasets and a folder called Inertia Signals -- this folder is not used for this assignment.

2) Description of variables (original datasets)
The X_test.txt and X_train.txt files contain measurements for multiple variables as described in features.txt.

The y_test.txt and y_train.txt files contain label information for each measurement the X_test.txt or X_train.txt file recorded. The description of each label can be found in activity_labels.txt

The subject_test.txt and subject_test.txt record the identity of volunteers participating in the experiment. There're 30 volunteers total, and thus subject ranges from 1 to 30.

3) Steps made to answer problem 1 thru 5
To begin with, read all files into R using read.table().

For problem 1, simply use cbind() and rbind() to merge all datasets

For problem 2 --
First, need to find out the variable names containing "mean" or "std". Those variable names can be found by searching the dataset of features, using grep().
Second, extract only the measurement data of those selected variables. Those data are then stored into the dataset "extractdata".

For problem 3 --
To replace the numeric label with descriptive strings, there're two methods. The first is to use replace(); the second is to use factor(). Both methods are illustrated in the script.

For problem 4 --
To replace all variable names by descriptive strings, need to 1) match the variable indices with the features indices; 2) replace the variable indices by descriptive phrases of features. 1) is realized by which(), and 2) is realized by assign new value to old value.

For problem 5 --
To get the means of measurements for each combination of label & subject, need to extract a specific portion of data at a time, calculating the mean, and store the result. The process is realized using for loops.
The resulting dataset is recorded as dataset2.

4) cleaned datasets
After problem 1-4, dataset "extractdata" is generated. It contains only the measurements on mean and std, and each variable is labeled by descriptive name.

After problem 5, dataset "dataset2" is generated. It contains the averages of measurements from "extractdata", with respect to each combination of label and subject.
