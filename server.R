server <-
  function(input, output, session){

    # shinyalert(title = "DISCLAIMER:",
    #            text  = "Johns Hopkins University stopped updating the underlying dataset of this dashboard as of March 10th, 2023.
    #
    #                     With Covid cases rising rapidly once again this season, it is imperative that case data is made publicly available for individuals to take proper precautions.
    #
    #                     Please join me in emailing JHU's Center for Systems Science and Engineering (CSSE) at ___ and urge them to do the right thing and continue tracking COVID-19 Case Data again.",
    #            type  = "warning")

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
