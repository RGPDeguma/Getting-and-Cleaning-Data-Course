## Getting and Cleaning Data Course Project
This R Script, ***run_analysis.R***, demonstrate how to get and clean a data into a tidy form. The script uses the functions found the **R {base} package** to minimized run time issues and improve reproducibility of results. This script uses the **Human Activity Recognition Using Smartphones Dataset**. More information about the dataset can be found in the ***\UCI HAR Dataset\README.txt***.



## Data Source
The script automatically downloads the zip file, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, if **ANY** of the required files were not present in the current working directory. 



## Environment
The script is created under the following environment
~~~~
platform       x86_64-w64-mingw32          
arch           x86_64                      
os             mingw32                     
system         x86_64, mingw32             
status                                     
major          3                           
minor          4.2                         
year           2017                        
month          09                          
day            28                          
svn rev        73368                       
language       R                           
version.string R version 3.4.2 (2017-09-28)
nickname       Short Summer      
~~~~



## How To
Download the run_analysis.R and sourced it in your current working working directory, then run the command:
~~~~
getTidy()
~~~~
It will generate the tidydata.txt file that contains the average of each variable for each activity and each subject. Runtime may vary depending on the Internet Download Speed and/or Computer Specifications.

## Process
The **run_analysis.R** script performs the following on the *UCI HAR Dataset*:
1. Download and Unzip the files if not present in the current working directory
2. Combines, row-wise, the X, y, and subject files found in test and train folder into their respective data frames, **xJoinedDataFrame**, **yJoinedDataFrame**, and **subjectDataFrame**.
3. Cleans up the Measurement Variable (**featuresDataFrame**) names found in ***features.txt*** file by lowering the case of the characters then removing the parenthesis '()' characters and replacing the comma ',' and dash '-' characters with underscore '_' character. The result is a human friendly variable names.
4. Changing the Variable (Column) Names of the combined X Data Frame (**xJoinedDataFrame**) with the cleaned measurement variable names
5. Combines, column-wise, the three, **subjectDataFrame-yJoinedDataFrame-xJoinedDataFrame**, data frames in a single data frame, **xDataFrame**
6. Subsets the **xDataFrame** data frame to the extract the columns that contains the mean and standard deviation of each measurement.
7. Apply the Activity labels found in the ***actvity_labels.txt*** to the **xDataFrame$activity** columns
8. Calculate the Average of the Measurements Mean and Standard Deviation per Subject per Activity and stores it as **cleanData** data frame.
9. Dumps into the current working directory the **cleanData** data frame into a text file, **tidydata.txt**, as the independent tidy data set.
