# Download and unzip dataset (skip if unzipped folder already exists)
if(!file.exists("./UCI HAR Dataset")) {
    if(!file.exists("./UCI HAR Dataset.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./UCI HAR Dataset.zip", method = "curl")
    }
    unzip("./UCI HAR Dataset.zip")
}

# Merge the training and the test sets to create one data set
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep ="")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep ="")
combined <- rbind(X_train, X_test)

# Extract only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt", sep ="")
features <- as.character(features[,2])
meanCols <- grep("mean()", features, fixed = TRUE)
stdCols <- grep("std()", features, fixed = TRUE)
extracted <- combined[c(meanCols, stdCols)]


# Uses descriptive activity names to name the activities in the data set
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep ="")
subject_test<- read.table("./UCI HAR Dataset/test/subject_test.txt", sep ="")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep ="")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep ="")
subject <- rbind(subject_train, subject_test)
activity_code <- rbind(y_train, y_test)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep ="")
activity_labels <- as.character(activity_labels[,2])
activity_name <- activity_labels[activity_code[,1]]
tidydata <- cbind(subject, activity_code, activity_name, extracted)

# Appropriately label the data set with descriptive variable names.
names(tidydata) <- c("Subject","Activity_Code", "Activity", features[c(meanCols, stdCols)])

write.table(tidydata, file="./tidydata.txt", sep="\t", row.names=FALSE)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
summary <- tidydata %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
write.table(summary, file="./summary.txt", sep="\t", row.names=FALSE)
