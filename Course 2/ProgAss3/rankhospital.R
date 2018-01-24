rankhospital <- function(state, outcome, num = 1) {
        ## Read outcome data
        data <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
        allStates <- unique(data[, 7])
        outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
        
        ## Check that state and outcome are valid
        if (!state %in% allStates) stop("invalid state")
        if (!outcome %in% names(outcomes)) stop("invalid outcome")
        
        data <- data[, c(2, 7, outcomes[outcome])]
        names(data) <- c('hospital', 'state', 'outcome')
        
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        hospitals <- data[data$state == state, ]
        hospitals$outcome <- as.numeric(hospitals$outcome)
        hospitals <- na.omit(hospitals)
        hospitals <- hospitals[order(hospitals$outcome, hospitals$hospital), ]
        if (num == "best") return(head(hospitals, n = 1))
        if (num == "worst") return(tail(hospitals, n = 1))
        
        hospitals[num, 1]
}