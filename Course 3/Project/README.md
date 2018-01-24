# README

the goal of this project was to create a tidy dataset for subsequent analyses. Within this repository the original data, a transformed, tidy dataset, an R script, used for the cleaning of the data, a codebook and this ReadMe are included.

The original data was taken from:

Human Activity Recognition Using Smartphones DatasetVersion 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

### run_analysis.R
The R script included was used for the tidying of the original data. It performs following tasks in order:

1. The necessary packages are loaded
2. The original data is loaded into dataframes with descriptive names corresponding the original filenames
3. The ytest and ytrain dataframes are converted from numerical vectors to factorial vectors named respectively ytest\_factorial and ytrain\_factorial
4. The subject\_test and subject\_train vectors - containing the subject IDs - as well as the ytest\_factorial and ytrain\_factorial - containing the current activity - are added to the xtest and xtrain dataframes
5. The xtest and xtrain dataframes are given descriptive column names - the first two are called "ID" and "activity", and the remaining are named with the features dataframe, corresponding to the names in the original ReadMe.txt and features\_info.txt
6. The xtest and xtrain dataframe are combine into one dataframe, called "total", using the rbind() command, since the columns correspond and there is no overlap in the subjects handled in each dataframe (the rbind command places two dataframes underneath eachother, so the result has the same number of columns (563), but the number of rows is equal to the sum of the rows of both dataframes(10299))
7. From this dataframe the ID, activity and every column containing "mean" or "std()" except from the "meanFreq()" columns is selected, this results in a dataframe containing all 10299 observations and 68 columns (variables)
8. This dataframe is then grouped by ID and activit, summarized by their mean and order by ID and activity
9. Finally the resulting tidy dataframe is written into a txt file called "tidy_data.txt", this file can be easily read into the R workspace using the "read.table("tidy_data.txt", header = T) command, which will load a dataframe with variable names, ordered by ID and activity.