source('./R/other/setup.R')

header <-
  dashboardHeader() %>%
  tagAppendChild(div("Dan's Covid Dashboard",
                     style = 'display: block;
                              font-size: 1.5em;
                              margin-block-start: 0.5em;
                              font-weight: bold;
                              color: white',
                     align = 'center'),
                 .cssSelector = 'nav')

sidebar <-
  dashboardSidebar(id='',
                   titlePanel("Case Data Filters:"),
                   pickerInput('country_region', 'Country',
                               choices  = levels(case_data$country_region),
                               selected = "Worldwide",
                               multiple = FALSE,
                               options = list(`actions-box` = TRUE,
                                              `live-search` = TRUE)),
                   pickerInput('state_province', 'State/Province',
                               choices  = levels(case_data$state_province),
                               selected = 'Overall',
                               multiple = FALSE,
                               options = list(`actions-box` = TRUE,
                                              `live-search` = TRUE)),
                   pickerInput('county_district', 'County/District',
                               choices  = levels(case_data$county_district),
                               selected = 'Overall',
                               multiple = FALSE,
                               options = list(`actions-box` = TRUE,
                                              `live-search` = TRUE)),

                   titlePanel("Vaccine Data Filters:"),
                   pickerInput('vaccine_state', 'State/Territory',
                               choices  = levels(vaccine_data$location),
                               selected = "United States",
                               multiple = FALSE,
                               options = list(`actions-box` = TRUE,
                                              `live-search` = TRUE)),
                   radioButtons("vaccine_cum_pct_selection", "Aggregation", choices = c("Cumulative", "% Vaccinated"))
  )

body <-
  dashboardBody(
    titlePanel("COVID-19 Case Data"),
    fluidRow(
      column(6, plotlyOutput("new_covid_cases_plot")),
      column(6, plotlyOutput("covid_log_plot"))
    ),

    titlePanel("COVID-19 Vaccine Data"),
    fluidRow(
      column(6, plotlyOutput("covid_vaccine_plot"))
    )
  )

dashboardPage(header, sidebar, body)
