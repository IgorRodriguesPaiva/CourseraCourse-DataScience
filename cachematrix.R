## Put comments here that give an overall description of what your
## functions do

## This function creates a special "matrix" 
## object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    inv_m <- NULL
    set <- function(y) {
        x <<- y
        inv_m <<- NULL
    }
    get <- function() {
        x
    }
    setsolve <- function(solve){
        inv_m <<- solve
    }
    getsolve <- function(){
        inv_m
    }
    list(set = set, get = get,
         setsolve = setsolve,
         getsolve = getsolve)
}

## This function computes the inverse of the special 
## "matrix" returned by makeCacheMatrix above. If the 
## inverse has already been calculated (and the matrix 
## has not changed), then the cachesolve should retrieve 
## the inverse from the cache.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv_m <- x$getsolve()
    if(!is.null(inv_m)) {
        message("getting cached data")
        return(inv_m)
    }
    data <- x$get()
    inv_m <- solve(data, ...)
    x$setsolve(inv_m)
    inv_m
}

## Example: Type this in the console without the "##" marks:
## marikis <- matrix(c(1,0,0,2,1,0,3,4,1),3,3)
## list_marikis <- makeCacheMatrix(marikis)
## cacheSolve(list_marikis)
## cacheSolve(list_marikis)
