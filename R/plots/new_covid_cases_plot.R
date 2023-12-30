new_covid_cases_plot <- function(case_data){
  case_data %>%
    plot_ly(type="bar", x= ~date, y= ~new_cases, name="New Cases", color=I("darksalmon")) %>%
    add_lines(x= ~date, y= ~new_cases_7_day_avg, name="New Cases - 7 Day Average", color=I("black")) %>%
    layout(xaxis = list(title = 'Date'),
           yaxis = list(title = 'New Cases',
                        hoverformat = ",.0f"),
           legend = list(x = 0, y = 1),
           hovermode = 'x')
}
