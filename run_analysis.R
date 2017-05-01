#This code takes the UCI datasets combines the train and test sets and creates a tidy dataset


##Step 1: Merges the training and the test sets to create one data set.

## Read the datasets
train <- read.table("./UCI HAR Dataset/train/X_train.txt")

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")

test <- read.table("./UCI HAR Dataset/test/X_test.txt")

subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

##Get the info on the datasets
dim(train)
dim(test)
dim(subjectTrain)
dim(subjectTest)
dim(testLabels)
dim(trainLabels)
dim(features)
head(train)
head(test)
head(subjectTrain)
head(subjectTest)
head(testLabels)
head(trainLabels)

#create a combined dataset

combined<-rbind(train,test)

combinedLabels<-rbind(trainLabels,testLabels)

combinedSubject<-rbind(subjectTrain,subjectTest)
#check attibutes
dim(combined)
dim(combinedLabels)
dim(combinedSubject)
head(combined)
head(combinedLabels)
head(combinedSubject)


##Step 2: Extracts only the measurements on the mean and standard deviation for 
##each measurement. 

##put the column names on the file

names(combined)<-features[, 2]

##take only the means and standard deviations
keepcols<-grep("mean\\(\\)|std\\(\\)",names(combined))
combinedmnsd<-combined[,keepcols]



##Step 3: Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
mapLabels <- activityLabels[,2]
combinedLabels <- mutate(combinedLabels,V1=mapLabels[V1])

##Step 4: Appropriately labels the data set with descriptive variable names. 

##Clean the names

colnames(combinedLabels)[colnames(combinedLabels)=="V1"] <- "Activity"
colnames(combinedSubject)[colnames(combinedSubject)=="V1"] <- "Subject"
#combine the threee sets
combinedmnsd<-cbind(combinedmnsd,combinedLabels,combinedSubject)
#Clean the names more
names(combinedmnsd) <- gsub("\\(\\)", "", names(combinedmnsd)) 
names(combinedmnsd) <- gsub("-", ".", names(combinedmnsd))
names(combinedmnsd) <- gsub(" ", ".", names(combinedmnsd))
names(combinedmnsd) <- gsub("mean", "Mean.Value", names(combinedmnsd))

##Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable
##for each activity and each subject.

summarySet<-group_by(combinedmnsd,Subject,Activity) %>%
  summarise_all(mean)
