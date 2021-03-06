#' Check the modulo 11 rules for CPR numbers
#'
#' @param cpr A vector of CPR number strings
#' @return A logical vector with values TRUE (CPR number ok), FALSE (CPR number not ok), or NA (cannot check)
#' @export
check_mod11 <- function(cpr) {

    cpr <- clean_cprstring(cpr)
    anyna <- is.na(date_of_birth(cpr))

    cprmatrix <- stringr::str_split_fixed(cpr, "", 10)
    class(cprmatrix) <- "integer"

    res <- as.vector((cprmatrix %*% c(4, 3, 2, 7, 6, 5, 4, 3, 2, 1) %% 11) == 0)
    res[anyna] <- NA
    return(res)
}


#' Check whether the CPR number is valid
#'
#' @param cpr A vector of CPR number strings
#' @return A logical vector with values TRUE (CPR number valid), FALSE (CPR number not valid), or NA (Not a proper date)
#' @export
is_cpr <- function(cpr) {
  # Check that date is a proper date
  dob <- date_of_birth(cpr)
  
  # Before October 1st 2007 check the mod 11 rule
  ifelse(dob<=as.Date("2007-09-30"), check_mod11(cpr), TRUE)
}



#' Check the modulo 11 rules for CPR numbers
#'
#' @param cpr A vector of potential CPR number strings
#' @return A vector of cleaned CPR number strings
#' @examples
#' cpr <- c("1010101234", "11111111", "101010-1234", "Cprnr : 101010-1234")
#' clean_cprstring(cpr)
#' @export
clean_cprstring <- function(cpr) {
    # Remove all non-numeric numbers
    cpr <- gsub("[^0-9]", "", cpr)
    # Check that it has exactly a length of 10 characters
    cpr[nchar(cpr) != 10] <- NA
    cpr
}
