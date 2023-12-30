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
                   sidebarMenu(
                     menuItem("COVID-19 Case Data", tabName = "case",       icon = icon("virus-covid")),
                     menuItem("Vaccine Data",       tabName = "vaccine",    icon = icon("syringe")),
                     menuItem("References",         tabName = "references", icon = icon("circle-info"))
                   )
  )

body <-
  dashboardBody(
    tabItems(
      tabItem(tabName = "case",
              titlePanel("COVID-19 Case Data"),
              fluidRow(
                column(2, box(title="Filters", status = "primary", solidHeader = TRUE, width = 12,
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
                                                         `live-search` = TRUE)))),
                column(5, box(title="New Cases Over Time", status = "primary", solidHeader = TRUE, width = 12,
                              plotlyOutput("new_covid_cases_plot"))),
                column(5, box(title="Covid Log Plot", status = "primary", solidHeader = TRUE, width = 12,
                              plotlyOutput("covid_log_plot")))
              )
      ),
      tabItem(tabName = "vaccine",
              titlePanel("COVID-19 Vaccine Data"),
              fluidRow(
                column(2, box(title="Filters", status = "primary", solidHeader = TRUE, width = 12,
                              pickerInput('vaccine_state', 'State/Territory',
                                          choices  = levels(vaccine_data$location),
                                          selected = "United States",
                                          multiple = FALSE,
                                          options = list(`actions-box` = TRUE,
                                                         `live-search` = TRUE)),
                              radioButtons("vaccine_cum_pct_selection", "Aggregation", choices = c("Cumulative", "% Vaccinated")))),
                column(5, box(title="Vaccine Doses Administered Over Time", status = "primary", solidHeader = TRUE, width = 12,
                              plotlyOutput("covid_vaccine_plot")))
              )
      ),
      tabItem(tabName = "references",
              titlePanel("References"))
    )
  )

dashboardPage(header, sidebar, body)
