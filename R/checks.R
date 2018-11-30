#' Check the modulo 11 rules for CPR numbers
#'
#' @param cpr A vector of cpr number strings
#' @return A logical vector with values TRUE (cpr number ok), FALSE (cpr number not ok), or NA (cannot check)
#' @export
check_mod11 <- function(cpr) {
  #  cpr <- clean(cpr)
  cpr <- strsplit(cpr, NULL)
  
  cpr <- lapply(cpr, function(cpr) {
    tryCatch(as.integer(cpr), warning = function(e) NA)
  })
  
  cpr <- lapply(cpr, function(cpr) {
    if(length(cpr) == 10) {
      x <- c(4, 3, 2, 7, 6, 5, 4, 3, 2, 1)
      sum(cpr * x) %% 11 == 0
    } else {
      FALSE
    }
  })
  
  unlist(cpr)
}



#' Check the modulo 11 rules for CPR numbers
#'
#' @param cpr A vector of cpr number strings
#' @return A logical vector with values TRUE (cpr number ok), FALSE (cpr number not ok), or NA (Not a proper date)
#' @export
valid_cpr <- function(cpr) {
  # Check date is a proper date
  dob <- date_of_birth(cpr)
  
  # Before October 1st 2007 check the mod 11 rule
  ifelse(dob<=as.Date("2007-09-30"), check_mod11(cpr), TRUE)
}
