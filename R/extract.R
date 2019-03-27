#' Returns the gender from a CPR number
#'
#' Gender is encoded in the last digit. If it is odd then it is a male, and if it is even then it is female.
#' 
#' @param cpr A vector of CPR numbers strings
#' @return A vector with gender as integer (0 = female, 1 = male)
#' @examples
#' gender("2310450637")  # This is testing out a randomly generated number
#' 
#' @export
gender <- function(cpr) {
    cpr <- clean_cprstring(cpr)
    #
    x <- as.numeric(substr(cpr, 10, 10)) %% 2

    return(x)
}
