library(dplyr)

#####FUNCTIONS SECTION

##Function to download zipfile
downloadData <-function(url, fileDestPath, fileName){
  
  file <- paste(fileDestPath,"/", fileName, sep = "")
  download.file(fileUrl,destfile=file)
  T
  
}

##Function to Read txt files
readData <- function(path, fileName) {
  
  file <- paste(path,"/", fileName, sep = "")
  dat <- read.table(file)
  dat
  
}

##Function to Write txt files
writeData <- function(path, fileName, dataset) {
  
  file <- paste(path,"/", fileName, sep = "")
  write.table(dataset, file, col.names = F)
  T
  
}

##end functions section


##Setting File and Path Names

rootPath <- "./UCI HAR Dataset"
trainPath <- "./UCI HAR Dataset/train"
testPath <- "./UCI HAR Dataset/test"

flNameActLabels <- "activity_labels.txt"
flNameFeatures <- "features.txt"

flNameSubject_train <- "subject_train.txt"
flNameMeasures_train <- "y_train.txt"
flNameData_train <- "X_train.txt"

flNameSubject_test <- "subject_test.txt"
flNameMeasures_test <- "y_test.txt"
flNameData_test <- "X_test.txt"

###DOWNLOADING AND EXTRACTING DATA
downloadData(urlFile, pathDest, downloadedFile)



###READING Files Section
##Reading Activities Labels And Features
tableActLabels <- readData(rootPath, flNameActLabels)
tableFeatures  <- readData(rootPath, flNameFeatures)

##Reading train Data
tableSubjectTrain   <- readData(trainPath, flNameSubject_train)
tableMeasuresTrain  <- readData(trainPath, flNameMeasures_train)
tableDataTrain      <- readData(trainPath, flNameData_train)

##Reading test Data
tableSubjectTest   <- readData(testPath, flNameSubject_test)
tableMeasuresTest  <- readData(testPath, flNameMeasures_test)
tableDataTest      <- readData(testPath, flNameData_test)

###END READING FILES SECTION

###TRANSFORM SECTION
##Combining Data sets Subjects and Activities
tableSubActTest  <- cbind(tableSubjectTest, tableMeasuresTest)
tableSubActTrain <- cbind(tableSubjectTrain, tableMeasuresTrain)


##merge to add Activities Labels in table
colNames <- c("Id.Subject", "Id.Activities")
names(tableSubActTest) <- colNames
names(tableSubActTrain) <- colNames
tableSubActTest  <- merge(tableSubActTest, tableActLabels, by.x = "Id.Activities", by.y = "V1")
tableSubActTrain <- merge(tableSubActTrain, tableActLabels, by.x = "Id.Activities", by.y = "V1")

##Setting Collumns Names
colNames <- c("Id.Activities","Id.Subject", "Des.Activities") 
names(tableSubActTest) <- colNames
names(tableSubActTrain) <- colNames
unames <- make.names(tableFeatures$V2, unique = TRUE)
names(tableDataTrain) <- unames
names(tableDataTest) <- unames

##Combining Data sets with Data Measurements and Subjects and Activities
tableTest <- cbind(tableSubActTest, tableDataTest)
tableTrain <- cbind(tableSubActTrain, tableDataTrain)

##Join the Train and Test Data
tableFull <- rbind(tableTest, tableTrain)

##Creating a deliverable dataset 
result <-
  tableFull %>%
  select(Id.Subject, Des.Activities, contains(".mean."), contains(".std.")) %>%
  group_by(Id.Subject, Des.Activities) %>%
  summarize(
    	mean(tBodyAcc.mean...X),
      mean(tBodyAcc.mean...Y),
    	mean(tBodyAcc.mean...Z),
    	mean( tGravityAcc.mean...X),	
    	mean(tGravityAcc.mean...Y),
    	mean(tGravityAcc.mean...Z),
    	mean(tBodyAccJerk.mean...X),	
    	mean(tBodyAccJerk.mean...Y),	
    	mean(tBodyAccJerk.mean...Z),	
    	mean(tBodyGyro.mean...X),
    	mean(tBodyGyro.mean...Y),
    	mean(tBodyGyro.mean...Z),
    	mean(tBodyGyroJerk.mean...X),
    	mean(tBodyGyroJerk.mean...Y),	
    	mean(tBodyGyroJerk.mean...Z),
    	mean(tBodyAccMag.mean..),
    	mean(tGravityAccMag.mean..),
    	mean(tBodyAccJerkMag.mean..),	
    	mean(tBodyGyroMag.mean..),
    	mean(tBodyGyroJerkMag.mean..),
    	mean(fBodyAcc.mean...X	),
    	mean(fBodyAcc.mean...Y),	
    	mean(fBodyAcc.mean...Z),	
    	mean(fBodyAccJerk.mean...X),
    	mean(fBodyAccJerk.mean...Y),
    	mean(fBodyAccJerk.mean...Z),
    	mean(fBodyGyro.mean...X),	
    	mean(fBodyGyro.mean...Y),	
    	mean(fBodyGyro.mean...Z),
    	mean(fBodyAccMag.mean..),	
    	mean(fBodyBodyAccJerkMag.mean..),	
    	mean(fBodyBodyGyroMag.mean..),
    	mean(fBodyBodyGyroJerkMag.mean..),	
    	mean(tBodyAcc.std...X),	
    	mean(tBodyAcc.std...Y),
    	mean(tBodyAcc.std...Z),	
    	mean(tGravityAcc.std...X),	
    	mean(tGravityAcc.std...Y),	
    	mean(tGravityAcc.std...Z),	
    	mean(tBodyAccJerk.std...X),	
    	mean(tBodyAccJerk.std...Y),	
    	mean(tBodyAccJerk.std...Z),	
    	mean(tBodyGyro.std...X),	
    	mean(tBodyGyro.std...Y),	
    	mean(tBodyGyro.std...Z),	
    	mean(tBodyGyroJerk.std...X),
    	mean(tBodyGyroJerk.std...Y),	
    	mean(tBodyGyroJerk.std...Z),	
    	mean(tBodyAccMag.std..),
    	mean(tGravityAccMag.std..),
    	mean(tBodyAccJerkMag.std..),	
    	mean(tBodyGyroMag.std..),	
    	mean(tBodyGyroJerkMag.std..),
    	mean(fBodyAcc.std...X),	
    	mean(fBodyAcc.std...Y),
    	mean(fBodyAcc.std...Z),
    	mean(fBodyAccJerk.std...X),	
    	mean(fBodyAccJerk.std...Y),	
    	mean(fBodyAccJerk.std...Z),
    	mean(fBodyGyro.std...X),
    	mean(fBodyGyro.std...Y),	
    	mean(fBodyGyro.std...Z),	
    	mean(fBodyAccMag.std..),
    	mean(fBodyBodyAccJerkMag.std..),
    	mean(fBodyBodyGyroMag.std..),
    	mean(fBodyBodyGyroJerkMag.std..)                              
    )
print(result)

finalFile <- "vTelles_finalFile.txt"
writeData(rootPath, finalFile, result)


