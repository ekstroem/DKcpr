---
title: "DKcpr"
output:
  html_document:
     keep_md: TRUE
---

# DKcpr

## Working with Danish CPR numbers in R


This note explains how to work with the Danish CPR numbers in R. The
majority of the information contained here is based on this wonderful
[Wikipedia article](https://da.wikipedia.org/wiki/CPR-nummer).

I've made an R package to handle validation of Danish cpr numbers. It
can be installed as follows:


```r
# Requires the devtools package to be installed in order to work
devtools::install_github("ekstroem/DKcpr")
```

## Getting the date of birth

The first 6 digits of the CPR number represent date-of-birth in the
format DDMMYY. Since some people can live longer than 100 years the
date does not uniquely specify the year that a person was born. For
example, could the string `101010` represent October 10th 2010 or
October 10th, 1910.

The 7th digit of the CPR number determines the century but the cut is
not trivial. Consequently, the `date_of_birth()` function returns the
date-of-birth as an R `Date` object in the format `YYYY-MM-DD`. As
input it accepts a vector of strings

For example:


```r
library("DKcpr")
cpr <- c("1010104321", "1010978726", "2310450637", "1010978726")
date_of_birth(cpr)
```

```
## [1] "2010-10-10" "1897-10-10" "1945-10-23" "1897-10-10"
```

We get `NA` if we enter CPR numbers that refer to illegal dates, or do not match the format, or contains text.


```r
date_of_birth(c("3510104321", "2902191234", "1111111", "Curious George"))
```

```
## Warning: 4 failed to parse.
```

```
## [1] NA NA NA NA
```

Working with the exact dates is easily done with the `lubridate`
package. For example, to extract the year we can use the `year()`
function:


```r
library("lubridate")
dob <- date_of_birth(cpr)
year(dob)
```

```
## [1] 2010 1897 1945 1897
```

## Verifying the validity of CPR numbes

The `is_cpr()` function can determine whether a CPR number is a valid
CPR number. It returns `TRUE` if it is a valid CPR number, `FALSE` if
it is not (i.e., is a date but does not fulfill the modulo 11 check), and `NA` if it is not a legal 10-digit number or date.


```r
is_cpr(cpr)
```

```
## [1]  TRUE FALSE  TRUE FALSE
```


## Working with CPR numbers

The `gender()` function returns the gender of the individuals. 0 = female, 1 = male.


```r
gender(cpr)
```

```
## [1] 1 0 1 0
```

