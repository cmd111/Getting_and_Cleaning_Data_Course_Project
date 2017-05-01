
# Getting_and_Cleaning_Data_Course_Project
Final Project for Coursera Getting and Cleaning Data

run_analysis.R reads in:

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Combines the test and controls sets

Adds the activity labels

Cleans the labels removing "-",")","("

and creates the dataset combinedmnsd

A group by and summarise are then used to create all variable means in the dataset summarySet
