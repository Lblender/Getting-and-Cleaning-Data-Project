setwd("C:/Users/linds/Documents/")

if (!("reshape2" %in% rownames(installed.packages())) ) { 
   print("Please install required package \"reshape2\" before proceeding") 
 } else { 

         library(reshape2) 
 
         activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("activity_id","activity_name")) 
 
         features <- read.table("UCI HAR Dataset/features.txt") 
         feature_names <-  features[,2] 
          
         testdata <- read.table("UCI HAR Dataset/test/X_test.txt") 
         colnames(testdata) <- feature_names 
          
         traindata <- read.table("UCI HAR Dataset/train/X_train.txt") 
         colnames(traindata) <- feature_names 
          
         test_subject_id <- read.table("UCI HAR Dataset/test/subject_test.txt") 
         colnames(test_subject_id) <- "subject_id" 
          
         test_activity_id <- read.table("UCI HAR Dataset/test/y_test.txt") 
         colnames(test_activity_id) <- "activity_id" 
          
         train_subject_id <- read.table("UCI HAR Dataset/train/subject_train.txt") 
         colnames(train_subject_id) <- "subject_id" 
          
         train_activity_id <- read.table("UCI HAR Dataset/train/y_train.txt") 
         colnames(train_activity_id) <- "activity_id" 
          
         test_data <- cbind(test_subject_id , test_activity_id , testdata) 
          
         train_data <- cbind(train_subject_id , train_activity_id , traindata) 
          
         all_data <- rbind(train_data,test_data) 
          
         mean_col_idx <- grep("mean",names(all_data),ignore.case=TRUE) 
         mean_col_names <- names(all_data)[mean_col_idx] 
         std_col_idx <- grep("std",names(all_data),ignore.case=TRUE) 
         std_col_names <- names(all_data)[std_col_idx] 
         meanstddata <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)] 
          
         descrnames <- merge(activity_labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE) 
          
         data_melt <- melt(descrnames,id=c("activity_id","activity_name","subject_id")) 
          
         mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean) 

         write.table(mean_data,"UCI HAR Dataset/tidy.txt") 
 

 } 
