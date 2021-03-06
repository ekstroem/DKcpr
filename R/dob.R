#' Returns the date-of-birth from a CPR number
#'
#' The first 6 digits of a CPR number contain the date-of-birth in a DDMMYY format. This format is not unique since only
#' two digits are available for the year, and the exact century can be derived from the last 4 digits.
#' 
#' @param cpr A vector of CPR numbers strings
#' @return A Date object with the date-of-births in YYYY-MM-DD format or NA if not a proper date
#' @examples
#' date_of_birth("2310450637")  # This is testing out a randomly generated number
#' @export
date_of_birth <- function(cpr) {

    cpr <- clean_cprstring(cpr)

    dd <- as.numeric(substr(cpr, 1, 2))
    mm <- as.numeric(substr(cpr, 3, 4))
    yy <- as.numeric(substr(cpr, 5, 6))
    x7 <- as.numeric(substr(cpr, 7, 7))

    
    yyyy <- yy + ifelse((is.na(cpr) | is.na(x7)), NA,
                 ifelse(x7<4, 1900,
                 ifelse(x7 == 4 & yy < 37, 2000, 
                 ifelse(x7 == 4, 1900,
                 ifelse(x7 == 5 & yy < 58, 2000,
                 ifelse(x7 == 5, 1800,
                 ifelse(x7 == 6 & yy < 58, 2000,
                 ifelse(x7 == 6, 1800,
                 ifelse(x7 == 7 & yy < 58, 2000,
                 ifelse(x7 == 7, 1800,
                 ifelse(x7 == 8 & yy < 58, 2000,
                 ifelse(x7 == 8, 1800,
                 ifelse(x7 == 9 & yy<37, 2000, 1900
                        )))))))))))))
    
    dob  <- lubridate::as_date(paste(yyyy, mm, dd, sep = '-'), tz="Europe/Copenhagen")
    
    return(dob)
}
