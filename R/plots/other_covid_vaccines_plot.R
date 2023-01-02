covid_vaccines_plot <- function(vaccine_data, cum_pct){

  if(cum_pct == "Cumulative"){
    vaccine_data %>%
      plot_ly(x= ~date, y= ~dose_1, name="Dose 1",
              type="scatter", mode="lines", fill="tozeroy", color = I("#CCE6FF")) %>%
      add_lines(x= ~date, y= ~fully_vaxxed, name="Fully Vaccinated",
                fill="tozeroy", color = I("#80BFFF")) %>%
      add_lines(x= ~date, y= ~booster_1, name="Booster 1",
                fill="tozeroy", color = I("#3399FF")) %>%
      add_lines(x= ~date, y= ~booster_2, name="Booster 2",
                fill="tozeroy", color = I("#0080ff")) %>%
      layout(legend = list(x = 0, y = 1),
             hovermode = 'x')
  }
  else{
    vaccine_data %>%
      plot_ly(x= ~date, y= ~dose_1_pct, name="Dose 1",
              type="scatter", mode="lines", fill="tozeroy", color = I("#CCE6FF")) %>%
      add_lines(x= ~date, y= ~fully_vaxxed_pct, name="Fully Vaccinated",
                fill="tozeroy", color = I("#80BFFF")) %>%
      add_lines(x= ~date, y= ~booster_1_pct, name="Booster 1",
                fill="tozeroy", color = I("#3399FF")) %>%
      layout(legend = list(x = 0, y = 1),
             hovermode = 'x')
  }
}
