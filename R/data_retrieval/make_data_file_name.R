make_data_file_name <- function(date, data_type){
  paste0("./data/", data_type, "_data_", format(today(), "%Y_%m_%d"), ".rds")
}
