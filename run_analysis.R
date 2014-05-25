##merge training and test set to create one set
##


runAnalysis <- function(){
    

    library(plyr)
    ds <- generateCompleteDataSet()
    

    ## dss = datasubset
    ## use grep command to select only the columns with mean or std in it
    dss <- ds[,grep("activity|subject|mean|std", colnames(ds))] 
    
    ## adjust all the header names to be more human readable and comply with the tidy dataset rules
    adjHeadNames <- adjustHeaderNames(names(dss))
    names(dss) <- adjHeadNames
    dss
        
    # dss[,2:78], because we do not want the mena of the first column 
    aggdss <- aggregate(dss[,3:81], by=list(activity=dss$activity,subject=dss$subject), FUN=mean, na.rm=FALSE)
    
    write.csv(aggdss, "subset_agg_sensor_data.csv", quote = TRUE, sep = ",")
    
    
}


## generate the complete dataset
## merge training and test set
## add headers
generateCompleteDataSet <- function() {
    
    ## generate feature vector 
    featTable <- read.table("data/features.txt")
    ##default the column was defined as factor
    featVec <- as.character(featTable[,2])
    featVec
    
    testSetX <- read.table("data/test/X_test.txt",header=FALSE)       
    testSetY <- read.table("data/test/Y_test.txt",header=FALSE)
    testSetObj <- read.table("data/test/subject_test.txt",header=FALSE)
    #convert to factor
    testSetY <- as.factor(as.matrix(testSetY))
    #testSetObj <- as.factor(as.matrix(testSetObj))
    
    testSet <- cbind(testSetY,testSetObj,testSetX)
    
    
    
    ## only change name of the first and second column
    names(testSet)[1] <- c("y")
    names(testSet)[2] <- c("a")
  
    
    trainSetX <- read.table("data/train/X_train.txt",header=FALSE)     
    trainSetY <- read.table("data/train/Y_train.txt", header=FALSE)
    trainSetObj <- read.table("data/train/subject_train.txt", header=FALSE)
    #convert to factor
    trainSetY <- as.factor(as.matrix(trainSetY))
    #trainSetObj <- as.factor(as.matrix(trainSetObj))
    trainSet <- cbind(trainSetY,trainSetObj,trainSetX)
    ## only change name of the first column
    names(trainSet)[1] <- c("y")
    names(trainSet)[2] <- c("a")
    
    #this is a plyr function to map factors
    #mapvalues(x, from = c("1", "2","3","4","5","6"), to = c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
    
    
    ##combine test and training set
    completeSet <- rbind(testSet,trainSet)
   
    
    
    #define header for the complete set
    names(completeSet) <- c("activity","subject",featVec)
   
    completeSet[,1] <- mapvalues(completeSet[,1], from = c("1", "2","3","4","5","6"), to = c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
    
    completeSet
}

adjustHeaderNames <- function(currentHeader) {
    newHeader <- vector()
    for(i in currentHeader)
    {
       
        i <- gsub("()","",i,fixed=TRUE)
        i <- gsub("-",".",i,fixed=TRUE)
        newHeader <- c(newHeader,tolower(i))
    }

    newHeader
}

