getTidy <- function() {
  
  # Loading the required files
  xTrainFile <- paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt")
  subjectTrainFile <- paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt")
  
  xTestFile <- paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt")
  subjectTestFile <- paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt")

  yTrainFile <- paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt")
  yTestFile <- paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt")
  
  activityFile <- paste0(getwd(),"/UCI HAR Dataset/activity_labels.txt")
  
  featuresFile<- paste0(getwd(), "/UCI HAR Dataset/features.txt")
  
  # Check if the Data is present in the current working directory
  if(!(file.exists(xTrainFile) 
       & file.exists(subjectTrainFile) 
       & file.exists(xTestFile) 
       & file.exists(subjectTestFile)
       & file.exists(yTrainFile)
       & file.exists(yTestFile)
       & file.exists(activityFile)
       & file.exists(featuresFile))){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    tempZipFile <- paste0(getwd(), "/temp.zip")
    
    # Download the zipfile if the data is not present
    # Check the Operating System for the propper download command
    if (Sys.info()['sysname'] == "Windows"){
      download.file(fileUrl, tempZipFile)
    } else {
      download.file(fileUrl, tempZipFile, method = "curl")
    }
    
    # Unzipped the files
    unzip(tempZipFile)
    
    # Removing the temporary zip file being downloaded
    file.remove(tempZipFile)
  }
  
  # Joining the X Data Sets
  xJoinedDataFrame <- rbind(read.table(xTrainFile), read.table(xTestFile))
  
  # Joining the Y Data Sets
  yJoinedDataFrame <- rbind(read.table(yTrainFile), read.table(yTestFile))
  colnames(yJoinedDataFrame) <- "activity"
  
  # Joining the Subject Data Sets
  subjectDataFrame <- rbind(read.table(subjectTrainFile),read.table(subjectTestFile))
  colnames(subjectDataFrame) <- "subject"
  
  featuresDataFrame <- read.table(featuresFile)
  
  # Cleaning the Features Data Frame in preparation for the Naming the columns
  featuresDataFrame[[2]] <- gsub("-","_", gsub(",","_", gsub("\\)","", gsub("\\(","", tolower(featuresDataFrame[[2]])))))
  
  # Adding the column names based on the Cleaned Features to X Data Sets
  colnames(xJoinedDataFrame) <- as.character(featuresDataFrame[[2]]) 
  
  # Combined Data of Train and Test
  # Step 1
  xDataFrame <- cbind(subjectDataFrame,yJoinedDataFrame,xJoinedDataFrame)
  
  # Selecting only the columns of measurements mean and standard deviation
  # Step 2
  cols <-c("subject","activity",grep("_mean[^freq]|_mean$|_std", names(xJoinedDataFrame), value = TRUE))
  xDataFrame <- xDataFrame[,cols]
  
  
  # Loading the Activities Data Frame
  # Step 3 and 4
  activityDataFrame <- read.table(activityFile)
  xDataFrame$activity <- sapply(xDataFrame$activity,
                       function(value,activityDataFrame){
                         return(activityDataFrame[value,2])
                       }, activityDataFrame)

  
  # Creating an Independent Data Set for Averages of each Subject and Activity
  # and saving it as tidydata.txt to the current working directory
  # Step 5  
  cleanData <- aggregate(xDataFrame[, !names(xDataFrame) %in% c("subject","activity")], by = list(xDataFrame$subject, xDataFrame$activity), FUN = mean)

  names(cleanData)[1] <- "subject"
  names(cleanData)[2] <- "activity"
  
  tData <- "tidydata.txt"
  write.table(cleanData, file = tData, row.names = TRUE)
  
}
