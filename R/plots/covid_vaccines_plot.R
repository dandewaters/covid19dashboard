covid_vaccines_plot <- function(vaccine_data, cum_pct){

  if(cum_pct == "Cumulative"){
    vaccine_data %>%
      plot_ly(x= ~date, y= ~admin_dose_1_cumulative, name="1+ Dose",
            type="scatter", mode="lines", fill="tozeroy", color = I("#CCE6FF")) %>%
      add_lines(x= ~date, y= ~series_complete_cumulative, name="Fully Vaccinated",
                fill="tozeroy", color = I("#80BFFF")) %>%
      add_lines(x= ~date, y= ~booster_cumulative, name="1+ Booster",
                fill="tozeroy", color = I("#3399FF")) %>%
      add_lines(x= ~date, y= ~second_booster_50plus_cumulative, name="2nd Booster (50+ Y/O's)",
                fill="tozeroy", color = I("#0080ff")) %>%
      layout(legend = list(x = 0, y = 1),
             hovermode = 'x')
  }
  else{
    vaccine_data %>%
      plot_ly(x= ~date, y= ~administered_dose1_pop_pct, name="1+ Dose",
              type="scatter", mode="lines", fill="tozeroy", color = I("#CCE6FF")) %>%
      add_lines(x= ~date, y= ~series_complete_pop_pct, name="Fully Vaccinated",
                fill="tozeroy", color = I("#80BFFF")) %>%
      add_lines(x= ~date, y= ~additional_doses_vax_pct, name="1+ Booster",
                fill="tozeroy", color = I("#3399FF")) %>%
      add_lines(x= ~date, y= ~second_booster_50plus_vax_pct, name="2nd Booster (50+ Y/O's)",
                fill="tozeroy", color = I("#0080ff")) %>%
      layout(legend = list(x = 0, y = 1),
             hovermode = 'x')
  }
}
