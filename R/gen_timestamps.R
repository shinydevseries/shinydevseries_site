gen_timestamps <- function(df, video_id) {

  df2 <- df %>%
    dplyr::mutate(time2 = lubridate::period_to_seconds(lubridate::hms(timestamp)),
          new_time = dplyr::if_else(recalc_flag,
                              time2 + lubridate::period_to_seconds(lubridate::hms("00:0:05")),
                              time2),
          new_time2 = lubridate::as_datetime(new_time),
          new_time_print = strftime(new_time2, format="%H:%M:%S"),
          youtube_minutes = lubridate::minute(lubridate::seconds_to_period(new_time)),
          youtube_seconds = new_time - (60 * youtube_minutes),
          youtube_seconds = dplyr::if_else(youtube_seconds < 10,
                                    paste0("0", youtube_seconds),
                                    as.character(youtube_seconds))
          ) %>%
    dplyr::select(., -timestamp) %>%
    dplyr::select(timestamp = new_time_print, youtube_time = new_time, description, youtube_minutes, youtube_seconds) %>%
    dplyr::mutate(timestamp_print_clean = glue::glue("{timestamp}"),
          timestamp_print_link = glue::glue("[{timestamp_print_clean}](https://youtube.com/watch?v={video_id}&t={youtube_time}s)")) %>%
    dplyr::mutate(website_print = glue::glue("{timestamp_print_link} {description} </br>"),
          youtube_print = glue::glue("{timestamp_print_clean} {description}"))

  return(df2)

}

library(dplyr)

youtube_id <- "21MnLDuRbS8"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:01:31", FALSE, "Mike's introductiona and journey with R & Shiny",
  "00:07:20", FALSE, "Data science consulting and Ketchbrook Analytics",
  "00:11:40", FALSE, "Olivia Adams' inspiring story",
  "00:17:40", FALSE, "Demo of Mike's COVID-19 At-Home Test Spotter App",
  "00:31:55", FALSE, "App code introduction",
  "00:32:10", FALSE, "googleway package integrating the Google Maps API",
  "00:36:25", FALSE, "Pulling addresses from map searches",
  "00:41:10", FALSE, "Using MongoDB for records collection",
  "00:43:15", FALSE, "bslib to simulate the multi-page app experience",
  "00:46:20", FALSE, "Episode wrapup"
)

df2 <- gen_timestamps(df, youtube_id)

cat(df2$website_print, sep = "\n")
cat(df2$youtube_print, sep = "\n")