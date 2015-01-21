## Coursera – Getting and Cleaning Data – Peer Assessment

### Data
Data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available on this [site][1].

### Main Variables
- combined: Combined data set containing the training set and the test set
- features: List of all features.
- meanCols: List of all features ending with *mean()*.
- stdCols: List of all features ending with *std()*.
- extracted: Dataset where only the measurements on the mean and standard deviation for each measurement from *combined* are kept.
- subject: List of the IDs of all subjects who performed the activity for each sample of the data. It ranges from 1 to 30.
- activity_code: List of activity codes for each sample of the data. Ranges from 1 to 6
- activity_name: List of activity labels for each sample of the data, obtained by matching labels in *activity_labels.txt* for each unique activity code.
- tidydata: A data set coming from the merging of *extract*, *subject*, *activity_code* and *activity_name* with descriptive columns name.
- summary: A data set with the average of each variable grouped by activity and subject.

### Transformations 
- The training set and the test set are merged to create only one data set called *combined*
- The measurements of the mean and standard deviation for each measurement are extracted, by first loading *feature.txt* to get the list of feature names and then filtering it. This data is stored in the *extracted* variable
- Three columns are added at the beginning,  one for *subject*, one for the *activity code* and one for the *activity name*. The data for it is extracted from other text files in the data set.
- The data set is labeled with descriptive columns name and stored in the *tidydata* variable. This is also written out to a file **tidydata.txt**.
- Finally, using the dplyr package, *tidydata* is summarized create a dataset *summary* with the average of each variable for each activity and each subject. This data is exported to the text file **summary.txt**.

[1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones