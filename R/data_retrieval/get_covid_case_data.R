get_covid_case_data <- function(todays_case_data_file_name, force_reload=FALSE){
  # Check if we downloaded today's data already or if
  if(!file.exists(todays_case_data_file_name) | force_reload){
    # Download case data from Bing's GitHub repository
    case_data <- readr::read_csv(file = "https://media.githubusercontent.com/media/microsoft/Bing-COVID-19-Data/master/data/Bing-COVID19-Data.csv",
                                 col_types = readr::cols(ID = readr::col_number(),
                                                         Updated = readr::col_date(format="%m/%d/%Y"),
                                                         Confirmed = readr::col_number(),
                                                         ConfirmedChange = readr::col_number(),
                                                         Deaths = readr::col_number(),
                                                         DeathsChange = readr::col_number(),
                                                         Recovered = readr::col_number(),
                                                         RecoveredChange = readr::col_number(),
                                                         Latitude = readr::col_number(),
                                                         Longitude = readr::col_number(),
                                                         ISO2 = readr::col_factor(),
                                                         ISO3 = readr::col_factor(),
                                                         Country_Region = readr::col_factor(),
                                                         AdminRegion1 = readr::col_character(),
                                                         AdminRegion2 = readr::col_character())) %>%

      # change column names from camelcase to underscore/change column names to more intuitive ones
      rename(date = Updated,
             new_cases = ConfirmedChange,
             new_deaths = DeathsChange,
             new_recovered = RecoveredChange,
             state_province = AdminRegion1,
             county_district = AdminRegion2) %>%
      # Cast column names to lowercase
      rename_with(tolower) %>%

      # Replace NA's in location columns to "overall" and cast to factors
      mutate(state_province = if_else(is.na(state_province), "Overall", state_province),
             state_province = as.factor(state_province),
             county_district = if_else(is.na(county_district), "Overall", county_district),
             county_district = as.factor(county_district)) %>%

      # Remove rows with negative new case values
      mutate(new_cases = if_else(new_cases < 0, NA_real_, new_cases)) %>%

      # Get the average and totals of new cases of last 7 days, and then the change in average and total new cases of last 7 days
      group_by(country_region, state_province, county_district) %>%
      mutate(new_cases_7_day_avg = frollmean(new_cases, 7, fill=NA, align="right", na.rm=TRUE, hasNA=TRUE),
             new_cases_7_day_avg_change = new_cases_7_day_avg - lag(new_cases_7_day_avg),
             new_cases_7_day_sum = frollsum(new_cases, 7, fill=NA, align="right", na.rm=TRUE, hasNA=TRUE),
             new_cases_7_day_sum_change = new_cases_7_day_sum - lag(new_cases_7_day_sum)) %>%
      ungroup()

    # Save today's data to an RData file
    saveRDS(case_data, todays_case_data_file_name)
    case_data
  } else{
    # Load data from the file if one exists for today's data
    readRDS(todays_case_data_file_name)
  }
}
