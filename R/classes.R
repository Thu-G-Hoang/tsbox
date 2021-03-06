
#' Universal Converter Function
#' 
#' @param x time series object, either `ts`, `xts`, `data.frame` or `data.table`.
#' @return returns a function
#' @export
coerce_to_ <- function(x){
  # print(x)
  stopifnot(x %in% c("xts", "ts", "data.frame", "data.table", "tbl", "dts"))
  get(paste0("ts_", x))
}

desired_class <- function(ll){
  z <- unique(vapply(ll, relevant_class, ""))
  if (length(z) == 1){
    if (z == "ts"){
      # no "ts" if mixed frequecies
      if (length(unique(vapply(ll, frequency, 1))) > 1) return("data.frame")
    }
    return(z)
  } else {
    return("data.frame")
  }
}

#' Extract the Relavant Class
#' 
#' @param x time series object, either `ts`, `xts`, `data.frame` or `data.table`.
#' @export
relevant_class <- function(x){
  if (inherits(x, "dts")){
    return("dts")
  }
  if (inherits(x, "ts")){
    return("ts")
  }
  if (inherits(x, "xts")){
    return("xts")
  }
  if (inherits(x, "data.table")){
    return("data.table")
  }
  if (inherits(x, "tbl")){
    return("tbl")
  }
  if (inherits(x, "data.frame")){
    return("data.frame")
  }
}

#' Reclass an object to a ts-boxable series
#'
#' Inspired by the similarly named function from the xts package
#' 
#' @param z series to reclass
#' @param x template series
#' @export
ts_reclass <- function(z, x){
  supported.classes <- c("ts", "mts", "xts", "data.frame", "data.table", "tbl", "dts")
  if (!class(z)[1] %in% supported.classes){
    if (inherits(x, "ts")){
      z <- ts(z)
      tsp(z) <- tsp(x)
    } else{
      return(z)
      # stop("No reclass for object of class: ", paste(class(z), collapse = ","))
    }
  }
  coerce_to_(relevant_class(x))(z)
}