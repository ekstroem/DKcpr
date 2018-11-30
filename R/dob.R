#' Returns the date-of-birth from a CPR number
#'
#' @param cpr A vector of CPR numbers strings
#' @return A Date object with the date-of-births in YYYY-MM-DD format or NA if not a proper date
#' @examples
#' date_of_birth("2310450637")  # This is testing out a randomly generated number
#' @export
date_of_birth <- function(cpr) {

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
    
    dob  <- paste(yyyy, mm, dd, sep = '-')
    dob  <- tryCatch(as.Date(dob, origin = '1970-01-01'),
                     error = function(e) NA)
    if(any(is.na(dob))) {
        warning(paste('Contains invalid CPR number. NA returned.'),
                call. = FALSE)
    }
    
    return(dob)
}
