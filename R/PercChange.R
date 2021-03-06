#' Calculate the percentage change from a specified lag, including withing group  
#' 
#' @param data a data frame object.
#' @param Var a character string naming the variable you would like to find the percentage change for.
#' @param GroupVar a character string naming the variable grouping the units within which the percentage change will be found for (i.e. countries in a time series). If \code{GroupVar = NULL} then the entire data frame is treated as one unit. 
#' @param NewVar a character string specifying the name for the new variable to place the percentage change in.
#' @param slideBy numeric value specifying how many rows (time units) to make the percentage change comparison for. Positive values shift the data up--lead the data.
#' @param type character string set at either \code{percent} for percentages or \code{proportion} to find proportions.
#' 
#' @return a data frame
#' @details Finds the percentage or proportion change for over a given time period either within groups of data or the whole data frame. Important: the data must be in time order and, if groups are used, group-time order.
#' 
#' @examples
#' # Create fake data frame
#' A <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2)
#' B <- c(1:10)
#' Data <- data.frame(A, B)
#' 
#' # Find percentage change from two periods before
#' Out <- PercChange(Data, Var = 'B', GroupVar = NULL, 
#'          type = 'proportion', NewVar = 'PercentChange', slideBy = -2)
#' 
#' Out
#' @export

PercChange <- function(data, Var, GroupVar = NULL, NewVar = NULL, slideBy = -1, type = "percent"){
  if (!(type %in% c('proportion', 'percent'))){
    stop("type must be either 'proportion' or 'percent'." )
  }
  if (is.null(NewVar)){
    NewVar = paste0(Var, '_PChangeFrom', slideBy)
  } 
  Temp <- slide(data = data, Var = Var, GroupVar = GroupVar, NewVar = NewVar, slideBy = slideBy)
  Temp[, NewVar] <- (Temp[, Var]- Temp[, NewVar])/Temp[, NewVar]
  
  if (type == 'percent'){
    Temp[, NewVar] <- Temp[, NewVar]*100
  }
  Temp
}