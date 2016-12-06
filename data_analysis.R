
#Check if directory and file exists
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
  
#Activity files test,train
  activitytest<-read.table("./data/UCI HAR Dataset/test/y_test.txt",header = F)
  activitytrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt",header = F)
  
#Subject files test,train
  subjecttest<-read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = F)
  subjecttrain<-read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = F)
#Features files test,train
  featurestest<-read.table("./data/UCI HAR Dataset/test/X_test.txt",header = F)
  featurestrain<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header = F)
  
#merging training and test sets into a data set

    activitydata<-rbind(activitytest,activitytrain)
    subjectdata<-rbind(subjecttest,subjecttrain)
    featuresdata<-rbind(featurestest,featurestrain)
    
    names(activitydata)<-c("activity")
    names(subjectdata)<-c("subject")
    featurenames<-read.table("./data/UCI HAR Dataset/features.txt",header = F)
    names(featuresdata)<-featurenames$V2
    
    dataset1<-cbind(subjectdata,activitydata)
    dataset<-cbind(featuresdata,dataset1)
    
#extracting measurements on mean and sd
    columnames<-colnames(dataset)
    mean_and_std <- (grepl("activity" , columnames) | 
                       grepl("subject" , columnames) | 
                       grepl("mean.." , columnames) | 
                       grepl("std.." , columnames) 
    )
    dataset<-dataset[,mean_and_std==TRUE]
#adding descriptive names to the activities
    activityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt")
    dataset$activity<-as.character(dataset$activity)
    for (i in 1:6){
      dataset$activity[dataset$activity == i] <- as.character(activityLabels[i,2])
    }
    dataset$activity<-as.factor(dataset$activity)
    data<-dataset
    data$subject<-as.factor(data$subject)
    names(data)<-gsub("^t", "time", names(data))
    names(data)<-gsub("^f", "frequency", names(data))
    names(data)<-gsub("Acc", "Accelerometer", names(data))
    names(data)<-gsub("Gyro", "Gyroscope", names(data))
    names(data)<-gsub("Mag", "Magnitude", names(data))
    names(data)<-gsub("BodyBody", "Body", names(data))

#remove the intermeidate data sets    
     rm(dataset,dataset1)
    
#new tidy data set average of each variable for each activity and each subject
     library(dplyr);
     
     tidydata<-aggregate(. ~subject + activity, data, mean)
     tidydata<-tidydata[order(tidydata$subject,tidydata$activity),]
     
     write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
     
     
     