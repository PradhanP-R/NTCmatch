
#' Match Scientific Names
#'
#' This function matches user-provided scientific names with a predefined list of scientific names.
#' @param names A character vector of scientific names to be matched.
#' @return A data frame with the original names and a logical indicating if they were matched.
#' @export
match_NTC_names <- function(names) {
  if(!require(readxl)){
    install.packages("readxl")
    library(readxl)
  }
  if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr)
  }
  load(system.file("data", "NTCdata.RData", package = "NTCmatch"))

  # Match names with scientific names in my_dataframe
matched <- merge(Userdata, NTCdata, by.x = "Name", by.y = "Scientific_Name", all.x = TRUE)

# Replace NAs with "Not matched" for unmatched entries
matched$NTC[is.na(matched$NTC)] <- "--Do not match--"

# Select relevant columns to return
result <- matched[, c("Name", "NTC")]
names(result) <- c("Scientific_Name", "NTC")

return(result)
}

