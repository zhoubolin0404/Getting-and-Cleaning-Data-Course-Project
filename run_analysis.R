# Clean the environment
rm(list=ls())

# Test and install package
if (!require("dplyr")) {
  install.packages("dplyr")
}

# Load package
library(dplyr)

#Get train_X and train_Y to combine as train_Data
setwd("D:/R Data/UCI HAR Dataset/train")
a <- list.files(pattern=".*.txt")
train_Data <- do.call(cbind,lapply(a, read.table))

#Get test_X and test_Y to combine as test_Data
setwd("D:/R Data/UCI HAR Dataset/test")
b <- list.files(pattern=".*.txt")
test_Data <- do.call(cbind,lapply(b, read.table))

#Combine as dataset
dataset <- rbind(train_Data, test_Data)

# Returns the average and sd
apply(train_Data, 1, mean)
apply(train_Data, 1, sd)
apply(test_Data, 1, mean)
apply(test_Data, 1, sd)

# Change the 1-6 of Y to the corresponding activity
dataset$V1[dataset$V1 == 1] <-"WALKING"
dataset$V1[dataset$V1 == 2] <-"WALKING UPSTAIRS"
dataset$V1[dataset$V1 == 3] <- "WALKING_DOWNSTAIRS"
dataset$V1[dataset$V1 == 4] <- "SITTING"
dataset$V1[dataset$V1 == 5] <- "STANDING"
dataset$V1[dataset$V1 == 6] <- "LAYING"

# Get label
features <- read.table("D:/R Data/UCI HAR Dataset/features.txt")
feature <- rbind (features[,c(1,2)],
                  matrix(c(562,"activity", 563, "subject"), 
                         nrow = 2, byrow = TRUE))

# Assign labels to each column of the dataset separately
colnames(dataset) <- feature[,2]

# The averages of different activities form new data
act_mean <- aggregate(dataset$activity, dataset, mean)

# The average of different topics forms new data
sub_mean <- aggregate(act_mean$subject, act_mean, mean)
new_table <- sub_mean[,c(564,565)]

# Read data
write.table(new_table, 
            file = "D:/R Data/new_table.txt", 
            row.name = F, 
            quote = F)





