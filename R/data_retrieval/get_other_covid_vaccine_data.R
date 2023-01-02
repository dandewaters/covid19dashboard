get_covid_vaccine_data <- function(todays_vaccine_data_file_name, force_reload=FALSE){
  # Check if we downloaded today's data already
  if(!file.exists(todays_vaccine_data_file_name) | force_reload){
    vaccine_data <-
      # Download and format most recent CDC vaccine data file
      readr::read_csv(file = "https://data.cdc.gov/api/views/unsk-b7fc/rows.csv?accessType=DOWNLOAD",
                      col_select = c(Date, Location, Administered, Admin_Per_100K, Recip_Administered,
                                     Administered_Dose1_Recip, Administered_Dose1_Pop_Pct, Series_Complete_Yes,
                                     Series_Complete_Pop_Pct, Additional_Doses, Additional_Doses_Vax_Pct,
                                     Second_Booster),
                      col_types = readr::cols(Date = readr::col_date(format="%m/%d/%Y"),
                                              Location = readr::col_character(),
                                              Administered = readr::col_number(),
                                              Admin_Per_100K = readr::col_number(),
                                              Recip_Administered = readr::col_number(),
                                              Administered_Dose1_Recip = readr::col_number(),
                                              Administered_Dose1_Pop_Pct = readr::col_number(),
                                              Series_Complete_Yes = readr::col_number(),
                                              Series_Complete_Pop_Pct = readr::col_number(),
                                              Additional_Doses = readr::col_number(),
                                              Additional_Doses_Vax_Pct = readr::col_number(),
                                              Second_Booster = readr::col_number())) %>%
      # Cast column names to lowercase
      dplyr::rename(date=Date,
                    location=Location,
                    administered=Administered,
                    admin_per_100k=Administered_Dose1_Pop_Pct,
                    admin_recip=Recip_Administered,
                    dose_1=Administered_Dose1_Recip,
                    dose_1_pct=Administered_Dose1_Pop_Pct,
                    fully_vaxxed=Series_Complete_Yes,
                    fully_vaxxed_pct=Series_Complete_Pop_Pct,
                    booster_1=Additional_Doses,
                    booster_1_pct=Additional_Doses_Vax_Pct,
                    booster_2=Second_Booster) %>%
      # Cast US state and territory abbreviations to full names
      mutate(location = case_when(location == "US"  ~ " United States",
                                  location == "AS"  ~ "American Samoa",
                                  location == "BP2" ~ "Bureau of Prisons",
                                  location == "DC"  ~ "District of Columbia",
                                  location == "DD2" ~ "Department of Defense",
                                  location == "FM"  ~ "Federated States of Micronesia",
                                  location == "GU"  ~ "Guam",
                                  location == "IH2" ~ "Indian Health Services",
                                  location == "MH"  ~ "Marshall Islands",
                                  location == "MP"  ~ "Northern Mariana Islands",
                                  location == "PR"  ~ "Puerto Rico",
                                  location == "PW"  ~ "Palau",
                                  location == "RP"  ~ "Republic of Palau",
                                  location == "UM"  ~ "U.S. Minor Outlying Islands",
                                  location == "VA2" ~ "Veterans Affairs",
                                  location == "VI"  ~ "U.S. Virgin Islands",
                                  location %in% state.abb ~ state.name[match(location, state.abb)],
                                  TRUE ~ location),
             location = as.factor(location)) %>%
      # Sort rows by location and date
      dplyr::arrange(location, date)
    # Save data frame to RData files
    saveRDS(vaccine_data, todays_vaccine_data_file_name)
    vaccine_data
  }else{
    # Load data from the file if one exists for today's data
    readRDS(todays_vaccine_data_file_name)
  }
}
