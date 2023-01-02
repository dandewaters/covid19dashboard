library(shiny)
library(plotly)
library(tidyverse)
library(lubridate)
library(data.table)
library(purrr)

# Helper functions


# Execute Data Retrieval
source("./data_retrieval/make_data_file_name.R")
source("./data_retrieval/get_covid_case_data.R")
source("./data_retrieval/get_other_covid_vaccine_data.R")
source("./data_retrieval/get_data.R")

# Define plot functions
source("./plots/new_covid_cases_plot.R")
source("./plots/covid_log_plot.R")
source("./plots/other_covid_vaccines_plot.R")
