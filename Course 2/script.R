pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## directory is a char vector of length 1
        ## indicating the location of the CSV file
        
        ## pollutant is a char vector of length 1
        ## indicating the name of the pollutant for which we will 
        ## calculate the mean: 'sulfate' or 'nitrate'
        
        ## id is an integer vector indicating 
        ## the monitor ID nrs to be used
        
        ## Return the mean of the pollutant across all 
        ## monitors list in the id vector, ignoring NA values
        ## Do not round the result
        
        ids <- formatC(id, width = 3, flag = 0)
        values <- c()
        for (i in ids) {
                loc <- paste(paste(directory, i, sep = "/"), "csv", sep = ".")
                tab <- read.csv(loc)
                v <- tab[names(tab) == pollutant]
                values <- c(values, v[!is.na(v)])
        }
        mean(values)
}

complete <- function(directory, id = 1:332) {
        ## directory is a char vector of length 1
        ## indicating the location of the CSV file
        
        ## id is an integer vector indicating 
        ## the monitor ID nrs to be used
        
        ## Return a data frame of the form
        ## id   nobs
        ## 1    117
        ## 2    1047
        ## ...
        ## where id is the monitor id nr and nobs is
        ## the nr of complete cases
        
        ids <- formatC(id, width = 3, flag = 0)
        complete <- data.frame(id = NULL, nobs = NULL)
        for (i in ids) {
                loc <- paste(paste(directory, i, sep = "/"), "csv", sep = ".")
                tab <- read.csv(loc)
                nrcomplete <- sum(complete.cases(tab))
                complete <- rbind(complete, data.frame(id = i, nobs = nrcomplete))
        }
        
        return(complete)
}

corr <- function(directory, threshold = 0) {
        ## directory is a char vector of length 1
        ## indicating the location of the CSV file
        
        ## threshold is a numeric vector of length 1
        ## indicating the number of completely observed observations
        ## (on all variables) required to compute the correlation between 
        ## nitrate and sulfate; default is 0
        
        ## Return a numeric vector of correlations
        ## Do not round the result
        
        correlations <- numeric()
        compl <- complete(directory)
        above <- compl[compl$nobs > threshold,]
        for (i in above$id) {
                loc <- paste(paste(directory, i, sep = "/"), "csv", sep = ".")
                tab <- read.csv(loc)
                c <- cor(tab$sulfate, tab$nitrate, use = "complete.obs")
                correlations <- c(correlations, c)
        }
        return(correlations)
}







