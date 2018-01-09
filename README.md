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