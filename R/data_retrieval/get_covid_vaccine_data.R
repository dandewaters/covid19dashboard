get_covid_vaccine_data <- function(todays_vaccine_data_file_name, force_reload=FALSE){
  # Check if we downloaded today's data already
  if(!file.exists(todays_vaccine_data_file_name) | force_reload){
    vaccine_data <-
      # Download and format most recent CDC vaccine data file
      readr::read_csv(file = "https://data.cdc.gov/api/views/rh2h-3yt2/rows.csv?accessType=DOWNLOAD",
                      col_types = readr::cols(Date = readr::col_date(format="%m/%d/%Y"),
                                              MMWR_week = readr::col_number(),
                                              Location = readr::col_character(),
                                              Administered_Daily = readr::col_number(),
                                              Administered_Cumulative = readr::col_number(),
                                              Administered_7_Day_Rolling_Average = readr::col_number(),
                                              Admin_Dose_1_Daily = readr::col_number(),
                                              Admin_Dose_1_Cumulative = readr::col_number(),
                                              Admin_Dose_1_Day_Rolling_Average = readr::col_number(),
                                              date_type = readr::col_factor(),
                                              Administered_daily_change_report = readr::col_number(),
                                              Administered_daily_change_report_7dayroll = readr::col_number(),
                                              Series_Complete_Daily = readr::col_number(),
                                              Series_Complete_Cumulative = readr::col_number(),
                                              Series_Complete_Day_Rolling_Average = readr::col_number(),
                                              Booster_Daily = readr::col_number(),
                                              Booster_Cumulative = readr::col_number(),
                                              Booster_7_Day_Rolling_Average = readr::col_number())) %>%
      # Cast column names to lowercase
      rename_with(tolower) %>%
      # Cast US state and territory abbreviations to full names
      mutate(location = case_when(location == "US" ~ "United States",
                                  location == "AS" ~ "American Samoa",
                                  location == "DC" ~ "District of Columbia",
                                  location == "FM" ~ "Federated States of Micronesia",
                                  location == "GU" ~ "Guam",
                                  location == "MH" ~ "Marshall Islands",
                                  location == "MP" ~ "Northern Mariana Islands",
                                  location == "PR" ~ "Puerto Rico",
                                  location == "PW" ~ "Palau",
                                  location == "UM" ~ "U.S. Minor Outlying Islands",
                                  location == "VI" ~ "U.S. Virgin Islands",
                                  location %in% state.abb ~ state.name[match(location, state.abb)],
                                  TRUE ~ location),
             location = as.factor(location))
    # Save data frame to RData files
    saveRDS(vaccine_data, todays_vaccine_data_file_name)
    vaccine_data
  }else{
    # Load data from the file if one exists for today's data
    readRDS(todays_vaccine_data_file_name)
  }
}
