covid_log_plot <- function(case_data){
  case_data %>%
    plot_ly(type="scatter", mode="lines",
            x= ~confirmed, y= ~new_cases_7_day_sum,
            color=I("darksalmon"),
            hovertext = ~paste0("<b>Date:</b> ", date, "<br>",
                                "<b>Confirmed Cases:</b> ", prettyNum(confirmed, ","), "<br>",
                                "<b>New Cases (7 Day Sum):</b> ", prettyNum(new_cases_7_day_sum, ","), "<br>"),
            hoverinfo = "text") %>%
    layout(xaxis = list(type = "log", title = "Log Total Confirmed Cases"),
           yaxis = list(type = "log", title = "Log New Cases (7 Day Sum)"),
           legend = list(x = 0, y = 1))
}
