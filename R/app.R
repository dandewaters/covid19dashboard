source("./other/setup.R")

ui <- fluidPage(
  fluidRow(
    # Covid Case Visualizations
      titlePanel("COVID-19 Case Data"),

      # Filter Selection for country/state/county
      sidebarLayout(
        sidebarPanel(
          selectInput("country_region", "Country", choices=levels(case_data$country_region)),
          selectInput("state_province", "State/Province", ""),
          selectInput("county_district", "County/District", ""),
          ),
        mainPanel(
          plotlyOutput("new_covid_cases_plot"),
          plotlyOutput("covid_log_plot")
        )
      )
    ),

  # Covid Vaccine Visualizations
  fluidRow(
    titlePanel("COVID-19 Vaccine Data"),

    sidebarLayout(
      sidebarPanel(
        selectInput("vaccine_state", "State/Territory", choices = levels(vaccine_data$location)),
        radioButtons("vaccine_cum_pct_selection", "Aggregation", choices = c("Cumulative", "% Vaccinated")),
        ),
      mainPanel(
        plotlyOutput("covid_vaccine_plot")
      )
    )
  ),

  # References and background info
  fluidRow(
    titlePanel("References")
  )
)



server <- function(input, output, session) {
  # Logic for updating covid case data visualization input options
  get_state_province_choices = reactive({
    state_province_choices <-
      case_data %>%
      select(country_region, state_province) %>%
      filter(country_region == input$country_region) %>%
      select(state_province) %>%
      unique()
    state_province_choices$state_province
  })
  get_county_district_choices = reactive({
    county_district_choices <-
      case_data %>%
      select(country_region, state_province, county_district) %>%
      filter(country_region == input$country_region,
             state_province == input$state_province) %>%
      select(county_district) %>%
      unique()
    county_district_choices$county_district
  })

  observe({updateSelectInput(session, "state_province", choices = get_state_province_choices())})
  observe({updateSelectInput(session, "county_district", choices = get_county_district_choices())})

  filtered_case_data <- reactive({case_data %>%
                                  filter(country_region == input$country_region,
                                         state_province == input$state_province,
                                         county_district == input$county_district,
                                         !is.na(new_cases),
                                         !is.na(new_cases_7_day_avg))})

  # Plots for covid visualizations
  output$new_covid_cases_plot <- renderPlotly(new_covid_cases_plot(filtered_case_data()))
  output$covid_log_plot <- renderPlotly(covid_log_plot(filtered_case_data()))

  # Plots for vaccine visualizations
  filtered_vaccine_data <- reactive(vaccine_data %>%
                                      filter(#date_type == "Admin",
                                             location == input$vaccine_state))

  output$covid_vaccine_plot <- renderPlotly(covid_vaccines_plot(filtered_vaccine_data(),
                                                                input$vaccine_cum_pct_selection))
}

# Run the application
shinyApp(ui = ui, server = server)
