## Course project on Tidy Data
## February 2015
##

## Clean up the environment removing extraneous variables
## Also to avoid errors if I run this multiple times
rm (list = ls())

library (plyr)
library (dplyr)

## Can comment out below if data is already in the current working directory
## as instructions seem to indicate
## setwd ("D:/Training/Getting and Cleaning Data/UCI HAR Dataset")

## First read all the features
## Ran into this problem wherein summarize doesn't seem to like (, ), - and ,
## So lets replace all of them with underscore
## Possibly might not have been an issue for others who did not use summarize

f<- read.table ("features.txt", sep = " ")
f$V2 <- gsub ("-", "_", f$V2)
f$V2 <- gsub (",", "_", f$V2)
f$V2 <- gsub ("\\(", "_", f$V2)
f$V2 <- gsub (")", "_", f$V2)

## Read in the test and train data sets

x_test <- read.table ("./test/X_test.txt")
x_train <- read.table ("./train/x_train.txt")

## Add the column names we picked up from features into both test & train
colnames (x_test) <- f$V2
colnames (x_train) <- f$V2

## We only need those variables that are mean or stdev
## Assumption made that all such variables will have mean or std in their feature names
## Lets build a list containing only the columns we need

cols_containing_mean <- grep ("mean", f$V2, value = TRUE)
cols_containing_std <- grep ("std", f$V2, value = TRUE)
needed_cols <- c(cols_containing_mean, cols_containing_std)

## Ignore 
##ditch_cols <- as.character (f$V2 [!(f$V2 %in% needed_cols)])

## Subset both test and train so as to keep only the columns we need

x_test<- x_test [,(names(x_test) %in% needed_cols)]
x_train<- x_train [,(names(x_train) %in% needed_cols)]

## Read in the subjects data files and add these as an additional column to test and train data frames
## Subjects are the people numbered 1 to 30

Subject <- read.table ("./test/subject_test.txt")
x_test$Subject <- Subject$V1

Subject <- read.table ("./train/subject_train.txt")
x_train$Subject <- Subject$V1

## Similarly read in the activity data files and add Activity column to both test and train data frames

Activity <- read.table ("./test/y_test.txt")
x_test$Activity <- Activity$V1

Activity <- read.table ("./train/y_train.txt")
x_train$Activity <- Activity$V1

## Combine test and train data frames into a single one now
test_train <- rbind (x_test, x_train)

## Need to replace the activity ids with the activity names now
## Read in the activity names data file
activity_names <- read.table ("activity_labels.txt")
activity_names$V2 <- as.character (activity_names$V2)

## Replace activity ids with activity names in the test + train data frame
test_train$Activity <- mapvalues (test_train$Activity, from = activity_names$V1, to = activity_names$V2)

## Make subject and activity as factors for grouping coming up next
test_train$Subject <- as.factor (test_train$Subject)
test_train$Activity <- as.factor (test_train$Activity)

## Group by subject and activity so that we can use summarize
grouped <- group_by (test_train, Subject, Activity)

## avg_df is my final data frame, initialize to empty 
## Possibly some other functions would have let me avoid the For loops
## To do: Investigate other alternative functions later 

avg_df <- NULL

for (i in 1:(ncol (grouped) - 2))  ## Don't need to summarize last 2 cols - Subject & Activity which I added last
{
    ## Some crazy problems I ran into which required the below code
    ## Summarize needs a literal column name, a name in quotes is not acceptable
    ## But I need to iterate through the 100+ different column names 
    ## and cannot therefore provide literal column names to summarize
    ## Therefore built a string with the summarize command and its parameters
    ## and passed it to eval/parse to execute the string itself
    ## Not clear to me if there is an alternate way using summarize
  
    s<- sprintf ("summarize (grouped, average = mean (%s))", colnames (grouped)[i])
    tmp <- eval(parse(text=s))
    
    ## tmp now contains the subject, activity and average (for colnames (grouped)[i] )
    ## Next add the variable name itself as the last column
    
    tmp$Variable <- colnames (grouped)[i]
    
    ## Append the data frame so that we accumulate average for all variables
    avg_df <- rbind (avg_df, tmp)
}

## Write out the data frame for submission
write.table (avg_df, file = "Tidy Results.txt", row.names = FALSE)

