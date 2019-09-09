rankhospital <- function(state, outcome, num){
    
    ## Getting and cleaning data:
    Data <- read.csv("outcome-of-care-measures.csv", 
                     colClasses = "character", na.strings="Not Available")

    
    ## This part of the code checks if the inputs are correct: 
    
    ValidOutcome <- outcome %in% c("heart attack", 
                                   "heart failure",
                                   "pneumonia")
    
    ValidState <- state %in% Data$State
    
    if (!ValidState){
        stop("invalid state")
    }
    
    if (!ValidOutcome){
        stop("invalid outcome")
    }
    
    ## Once the imputs are good, the program set the right column
    ## according to the passed outcome.
    
    if (outcome == "heart attack"){
        
        UseColumn <- 11
    }
    else if (outcome == "heart failure"){
        
        UseColumn <- 17
    }
    else if (outcome == "pneumonia"){
        
        UseColumn <- 23
    }
    
    ## Cleanning data:
    DataClean <- Data[complete.cases(Data[,UseColumn]),]
    
    ## Subset the data according to the state:
    DataOnState <- subset(DataClean, State == state)
    
    ## Sort data by the minimum value in the outcome column:
    SortData <- DataOnState[order(as.numeric(DataOnState[,UseColumn]),
                                  DataOnState[,"Hospital.Name"]),]
    
    ## Set the rank value to a numeric according to the outcome
    if (num == "best"){
        rank <- 1
    }
    else if ( num == "worst"){
        rank <- as.numeric(nrow(DataOnState))
    }
    else {
        rank <- num
    }
    
    return(SortData[rank,]$Hospital.Name)
    
}