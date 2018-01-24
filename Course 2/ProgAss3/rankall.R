rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
        allStates <- unique(data[, 7])
        outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
        
        ## Check that state and outcome are valid
        if (!state %in% allStates) stop("invalid state")
        if (!outcome %in% names(outcomes)) stop("invalid outcome")
        
        data <- data[, c(2, 7, outcomes[outcome])]
        names(data) <- c('hospital', 'state', 'outcome')
        
        ## For each state, find the hospital of the given rank
        ldf <- split(data, data$state)
        ranks <- lapply(ldf, rankdata, outcome = outcome, num = num)
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        data.frame(hospital = unlist(ranks), state = names(ranks))
}

rankdata <- function(data, outcome, num = 1) {
                ## Return hospital name in that state with lowest 30-day death
                ## rate
                data$outcome <- as.numeric(data$outcome)
                data <- na.omit(data)
                data <- data[order(data$outcome, data$hospital), ]
                if (num == "best") return(head(data[, 1], n = 1))
                if (num == "worst") return(tail(data[, 1], n = 1))
                
                data[num, 1]
}




