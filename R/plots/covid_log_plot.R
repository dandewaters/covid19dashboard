covid_log_plot <- function(case_data){
  case_data %>%
    plot_ly(type="scatter", mode="lines",
            x= ~confirmed, y= ~new_cases_7_day_sum,
            color=I("darksalmon")) %>%
    layout(xaxis = list(type = "log"), yaxis = list(type = "log")) %>%
    layout(legend = list(x = 0, y = 1))
}