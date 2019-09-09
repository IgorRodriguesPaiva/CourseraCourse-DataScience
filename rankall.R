rankall <- function(outcome, num = "best"){
    
    ## Getting and cleaning data:
    Data <- read.csv("outcome-of-care-measures.csv", 
                     colClasses = "character", na.strings="Not Available")
    
    ## This part of the code checks if the inputs are correct: 
    
    ValidOutcome <- outcome %in% c("heart attack", 
                                   "heart failure",
                                   "pneumonia")
    
    if (!ValidOutcome){
        stop("invalid outcome")
    }
    
    ## Once the imputs are good, the program sets the right column
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
    
    
    RankList <- data.frame()
    ListOfStates <- unique(Data$State)
    ListOfStates <- sort(ListOfStates)
    
    ## Cleanning data:
    DataClean <- Data[complete.cases(Data[,UseColumn]),]
    
    for (i in ListOfStates) {

        ## Create a data.frame of the current state:
        DataOnState <- subset(DataClean, State == i)
        
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
        
        ## Sort data by the minimum value in the outcome column:
        SortData <- DataOnState[order(as.numeric(DataOnState[,UseColumn]),
                                      DataOnState[,"Hospital.Name"]),]
        
        NewHospital <- data.frame(hospital = SortData[rank,]$Hospital.Name,
                                  state = i)
        
        RankList <- rbind(RankList,NewHospital)
    
    }
    
    return(RankList)
} 
