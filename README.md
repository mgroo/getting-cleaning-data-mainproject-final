Read me about the functions to create the tidy dataset
======================================================

Introduction
------------
All the used data can be found within the data folder.
The R script run_analysis.R consists out of three functions.

* runAnalysis: this is the main part and calls other functions to get the data
* generateCompleteDataSet: this function generates/creates a clean dataset
* adjustHeaderNames: this function returns a cleaned set of variables which are the human readable headers
* generate output .csv file


runAnalysis
------------
The function takes the following steps

* load plyr from the library (please install the plyr package if you do not have it)
* then load a object ds with the function generateCompleteDataSet()
* load object dss with the grep command. The grep command makes shure only certain columns are selected. 
  in this case only columns that have activity, subject, mean or std in its name. This makes shure only the needed columns are              
  selected. I have decided to take all the collumns with mean and std in its name. This is to be shure that there are no needed 
  columns left out.
* Then human readable column names are created with the adjustHeaderNames function. 
* the new headers are added to the dss dataset. 
* The last step is aggregating the data on the activity and subject and calcualte the mean. Here the aggregate function is used.


generateCompleteDataSet
-----------------------

This function does the following

* Generate feature vector (featVec) from the text file with features
* Change the featVec class from factor to character string
* Load the testSet data from X_test.txt / Y_test.txt and data/test/subject_test.txt
* Convert the testSetY to factors. factors are easy to convert from id's to chars with PLYR
* Then bind the testSetY, testSetObj and testSetX. testSety and testSetObj go before the X values for readability
* Assign a temporary name (y,a) for the first two columns
* Do the same steps for the training set (X_train.txt/Y_train.txt/subject_train.txt)
* then use the plyr function mapvalues to map the factors from 1,2,3,4,5,6 to WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING
* combine the test and training set with rbind to generate a single set of data (completeSet)
* then define the final hunman readable names names for the columns in one go 
  
adjustHeaderNames    
-----------------

This function is responsible for change the column names in a human readable and correct format. 

For each header name it does the following
* replace () with nothing, so () gets erased
* replace - with .
* set the column names to lowercase


     
}