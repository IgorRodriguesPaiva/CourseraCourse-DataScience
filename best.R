best <- function(state, outcome){
    
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
    
    ## As we know the column to look and the state, the program subsets
    ## the data according to the state and the minimum value on that column.
    
    DataOnState <- subset(DataClean, State == state)
    minValue <- min(as.numeric(DataOnState[[UseColumn]]))
    LowMortality <- subset(DataOnState, 
                            as.numeric(DataOnState[[UseColumn]])==minValue)
        
    bestHospital <- LowMortality$Hospital.Name
    return(bestHospital)
}









