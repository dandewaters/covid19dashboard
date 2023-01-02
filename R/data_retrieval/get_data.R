todays_case_data_file_name <- make_data_file_name(today(), "case")
todays_vaccine_data_file_name <- make_data_file_name(today(), "vaccine")

case_data <- get_covid_case_data(todays_case_data_file_name)
vaccine_data <- get_covid_vaccine_data(todays_vaccine_data_file_name)
