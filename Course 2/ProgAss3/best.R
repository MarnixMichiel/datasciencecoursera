best <- function(state, outcome) {
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
        hospitals <- hospitals[order(hospitals$hospital), ]
        
        bst <- subset(hospitals, outcome == min(outcome, na.rm = TRUE))
        
        bst[1, 1]
}