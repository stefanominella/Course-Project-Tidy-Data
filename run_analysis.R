## Load activities labels
print("importing activity_labels.txt ...")
activity.labels <- read.csv("./UCI_HAR_Dataset/activity_labels.txt"
                            ,sep=" "
                            ,header=F
                            ,col.names=c("activity.id","activity.label")
)

## Load features labels
print("importing features.txt ...")
features.labels <- read.csv("./UCI_HAR_Dataset/features.txt"
                            ,sep=" "
                            ,header=F
                            ,col.names=c("feature.id","feature.label")
)

## Load activities IDs to join with the dataset
print("importing y_test.txt ...")
activity.test <- read.csv("./UCI_HAR_Dataset/test/y_test.txt"
                          ,sep=" "
                          ,header=F
                          ,col.names=c("activity.id")
)

## Load the subject IDs to # load the dataset join with the dataset
print("inporting subject_test.txt ...")
subject.test <- read.csv("./UCI_HAR_Dataset/test/subject_test.txt"
                         ,sep=" "
                         ,header=F
                         ,col.names=c("subject.id")
)

## Load the test data dataset
print("importing X_test.txt ...")
data.test <- read.fwf(file="./UCI_HAR_Dataset/test/X_test.txt",widths=c(rep(16,561)))

## Load activities IDs to join with the dataset
print("importing y_train.txt ...")
activity.train <- read.csv("./UCI_HAR_Dataset/train/y_train.txt"
                           ,sep=" "
                           ,header=F
                           ,col.names=c("activity.id")
)

## Load the subject IDs to join with the dataset
print("importing subject_train.txt ...")
subject.train <- read.csv("./UCI_HAR_Dataset/train/subject_train.txt"
                          ,sep=" "
                          ,header=F
                          ,col.names=c("subject.id")
)

## Load the train data dataset
print("importing X_train.txt ...")
data.train <- read.fwf(file="./UCI_HAR_Dataset/train/X_train.txt",widths=c(rep(16,561)))

print("generating tidy data set...")
## Label the data set variables using the labels from the features.txt file. 
colnames(data.test) <- features.labels$feature.label
colnames(data.train) <- features.labels$feature.label

## Add activity and subject IDs to the data sets
data.test <- cbind(subject.test,data.test)
data.test <- cbind(activity.test,data.test)

data.train <- cbind(subject.train,data.train)
data.train <- cbind(activity.train,data.train)

## Merge the two dataset together
merged.data <- rbind(data.test,data.train) 

## Extract only the measurements from mean,std,activity.id,subject.id 
merged.data <- merged.data[,grep("mean|std|\\.id",colnames(merged.data))]

## Add descriptive activity names to the data set
merged.data <- merge(activity.labels,merged.data,by="activity.id")

## Appropriately labels the data set with descriptive variable names
colnames(merged.data) <- gsub("\\(\\)","",colnames(merged.data))
colnames(merged.data) <- gsub("-","",colnames(merged.data))
colnames(merged.data) <- gsub("Acc","Acceleration",colnames(merged.data))
colnames(merged.data) <- gsub("std","StandardDeviation",colnames(merged.data))
colnames(merged.data) <- gsub("Gyro","Gyroscope",colnames(merged.data))
colnames(merged.data) <- gsub("Mag","Magnitude",colnames(merged.data))
colnames(merged.data) <- gsub("mean","Mean",colnames(merged.data))
colnames(merged.data) <- gsub("subject.id","subject",colnames(merged.data))
colnames(merged.data) <- gsub("activity.label","activityLabel",colnames(merged.data))

print("generating averages for each activity/subject ...")
## Compute the average of each variable for each activity and each subject.
tidy.dataset <- aggregate(merged.data[,grep("Mean|StandardDeviation",colnames(merged.data))]
                          ,by=list(activity=merged.data$activityLabel,subject=merged.data$subject)
                          , mean
)
print("saving tidy_data.txt file into r work directory ...")
write.table(tidy.dataset,"tidy_data.txt",row.name=FALSE)
print("done")


