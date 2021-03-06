## These functions allow an inverse matrix calculation to be cached and 
## stored to call later, such that when the matrix inversion operation 
## is being processed repeatedly in a loop structure or equivalent it need
## only be calculated and stored once, then called upon repeatedly thereafter.

## The following function creates a list with four elements. These elements
## are functions for setting a matrix in the current environment, for retrieving
## for that matrix, for calculating and setting the matrices inverse using solve()
## and for retrieving that inverse from the cache

makeCacheMatrix <- function(x = matrix()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setinverse <- function(solve) m <<- solve
            getinverse <- function() m
            list(set = set, get = get,
                 setinverse = setinverse,
                 getinverse = getinverse)
    }


## This function accepts the list generated by makeCacheMatrix and uses them to 
## conditionally solve an inverse matrix or, if that matrix has already been solved,
## retrieve the stored solution. As part of the solution, to operative iteratively,
## it will set the inverse matrix if its required to solve it such that future iterations
## of this code have the solution available to retireve rather than recalculate.

cacheSolve <- function(x, ...) {
            m <- x$getinverse()
            if(!is.null(m)) {
                    message("getting cached inverse matrix")
                    return(m)
            }
            data <- x$get()
            m <- solve(data, ...)
            x$setinverse(m)
            m
	}