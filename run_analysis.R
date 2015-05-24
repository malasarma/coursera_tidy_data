
run_analysis <- function() {
        library(reshape2)
# Step 1: read the input files as separate vectors

# set working dir: C:/Users/Mala Sarma/Documents/GettingCleaningData/course project/UCI HAR Dataset

#setwd("C:/Users/Mala Sarma/Documents/GettingCleaningData/course project/UCI HAR Dataset")
#getwd()
# 0: Read "activities_labels.txt" and "features.txt"

        activity_label <- read.csv("activity_labels.txt", sep = " ", header = FALSE)
        feature_v <- read.csv("features.txt", sep = " ", header = FALSE, col.names = c("", "var"))

  
## STEP 1: Create a combined data set
# 1-1: Read test/X_test.txt, and train/X_test.txt
        test <- read.table("test/X_test.txt", col.names = as.character(feature_v$var))
        train <- read.table("train/X_train.txt", col.names = as.character(feature_v$var))
        main_table <- rbind(test, train)

## STEP 2: Extracts only the measurements on the mean and standard
## deviation for each measurement.

# determine which columns contain "mean()" or "std()"
        sub_table <- main_table[grepl("\\.mean\\.", names(main_table)) | grepl("\\.std\\.", names(main_table))]
        
## STEP 3: Read test/y_test.txt, and train/y_test.txt for Activities, 
## Uses descriptive activity names to name the activities in the data set
        test <- read.table("test/y_test.txt", col.names="Activity")
        train <- read.table("train/y_train.txt", col.names="Activity")
        sub <- rbind(test, train)
        activity <- activity_label[sub$Activity, 2]

        sub_table <- cbind(Activity = activity, sub_table)
        
# 1-2: Read test/X_test.txt, and train/X_test.txt
        test <- read.table("test/subject_test.txt", col.names="Subject")
        train <- read.table("train/subject_train.txt", col.names="Subject")
        sub <- rbind(test, train)

        sub_table <- cbind(Subject = sub, sub_table)
        


## STEP 4: Appropriately label the data set with descriptive variable names
        names(sub_table) <- gsub("tBody", "Time.Body", names(sub_table))
        names(sub_table) <- gsub("tGravity", "Time.Gravity", names(sub_table))
        names(sub_table) <- gsub("fBody", "FFT.Body", names(sub_table))
        names(sub_table) <- gsub("fGravity", "FFT.Gravity", names(sub_table))

        
## STEP 5: creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject
# create the tidy data set
        melted <- melt(sub_table, id=c("Subject","Activity"))
        tidy <- dcast(melted, Subject+Activity ~ variable, mean)
        
        # write the tidy data set to a file
        write.csv(tidy, "tidy.csv", row.names=FALSE)
        write.table(tidy, "tidy.txt", row.names=FALSE)
        return(sub_table)

}