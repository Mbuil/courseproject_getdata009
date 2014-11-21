
## put the UCI HAR Dataset under R's working directory

## Read data separately into R
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

## name the columns of dataset
names(y_test) <- c("label")
names(y_train) <- c("label")
names(subject_test) <- c("subject")
names(subject_train) <- c("subject")

## merge data into two sets
testdata <- cbind(x_test,y_test,subject_test)
traindata <- cbind(x_train,y_train,subject_train)

## problem 1: merge test and train data
alldata <- rbind(traindata,testdata)

## problem 2: extract only measurements on the mean and std
## In features.txt, those measurements are marked with string
## "mean" or "std" in the middle or at the end of their 
## names

## match for "mean" and "std"
meanmatch <- grep("mean",features$V2)
stdmatch <- grep("std",features$V2)
match <- c(meanmatch,stdmatch)

## extract measurements of match features
extractdata <- alldata[,match]
## add label and subject columns
extractdata <- cbind(extractdata,alldata[,562],alldata[,563])
names(extractdata)[80] <- c("label")
names(extractdata)[81] <- c("subject")

## Problem 3: name activities in the dataset, that is, 
## replace the factors in label column with descriptive
## words
extractdata$label <- as.character(extractdata$label)
extractdata$label <- replace(extractdata$label,which(extractdata$label=="1"),as.character(activity_labels$V2[1]))
extractdata$label <- replace(extractdata$label,which(extractdata$label=="2"),as.character(activity_labels$V2[2]))
extractdata$label <- replace(extractdata$label,which(extractdata$label=="3"),as.character(activity_labels$V2[3]))
extractdata$label <- replace(extractdata$label,which(extractdata$label=="4"),as.character(activity_labels$V2[4]))
extractdata$label <- replace(extractdata$label,which(extractdata$label=="5"),as.character(activity_labels$V2[5]))
extractdata$label <- replace(extractdata$label,which(extractdata$label=="6"),as.character(activity_labels$V2[6]))

## do the same thing for alldata dataset using a different method
alldata$label <- factor(alldata$label,labels=as.character(activity_labels$V2))

## Problem 4: label variable names
## for dataset alldata
names(alldata)[1:561] <- as.character(features$V2)

## for dataset extractdata
## first, change the feature$V1 from 1 to "V1", etc so that
## it can be matched directly with label. It's done by paste()
features$V1 <- as.character(features$V1)
for(i in 1:561){
  features$V1[i] <- paste("V",features$V1[i],sep="")
}
## second, if colname matches features$V1, replace it by 
## features$V2(descriptive version of colnames)
for(i in 1:79){
  index <- which(features$V1==names(extractdata)[i])
  names(extractdata)[i] <- as.character(features$V2[index])
}
## the extractdata dataset now is labeled correctly

## Problem 5: from dataset extractdata, create another dataset
## with the average of each variable for each activity and
## each subject
## initialize dataset2
dataset2 <- matrix(c(1:81),nrow=1,ncol=81)

## for convenience, change the label column from character
## to numeric so that it can be averaged
## keep a copy of dataset before changing
excopy <- extractdata 

extractdata$label <- as.numeric(factor(extractdata$label,labels=c(1,2,3,4,5,6)))

for (i in 1:30){
  for (j in 1:6){
    tempset <- extractdata[extractdata$label==activity_labels$V1[j]&extractdata$subject==i,]
    tempmean <- sapply(tempset,mean)
    dataset2 <- rbind(dataset2,tempmean)
  }
}
dataset2 <- as.data.frame(dataset2[-1,])

## now change label back to factor
dataset2$label <- factor(as.numeric(dataset2$label),labels=as.character(activity_labels$V2))

## the dataset created thru problem 1-4 is extractdata
## the final dataset required by problem 5 is dataset2

write.csv(dataset2,file="projectData.csv", row.names=FALSE)
a <- as.matrix(dataset2)
