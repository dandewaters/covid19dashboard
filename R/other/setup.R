library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(shinyalert)
library(plotly)
library(fontawesome)
library(tidyverse)
library(lubridate)
library(data.table)
library(purrr)


# Helper functions


# Execute Data Retrieval
case_data <- read_rds('./data/case_data_2023_12_29.rds')
vaccine_data <- read_rds('./data/vaccine_data_2023_12_29.rds')
# source("./R/data_retrieval/make_data_file_name.R")
# source("./R/data_retrieval/get_covid_case_data.R")
# source("./R/data_retrieval/get_other_covid_vaccine_data.R")
# source("./R/data_retrieval/get_data.R")

# Define plot functions
source("./R/plots/new_covid_cases_plot.R")
source("./R/plots/covid_log_plot.R")
source("./R/plots/other_covid_vaccines_plot.R")
