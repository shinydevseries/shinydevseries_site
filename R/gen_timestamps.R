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

youtube_id <- "GdxVtl3FwmI"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:00:46", FALSE, "CRUD workflow and flowchart, with MongoDB database updates",
  "00:09:41", FALSE, "Diving into the Google Maps and Places API",
  "00:15:55", FALSE, "Geographic fencing, and dealing with unexpected user behavior. ",
  "00:22:35", FALSE, "Deploying with a dev and production branch.",
  "00:28:15 ", FALSE, "Future plans for the app",
  "00:30:50", FALSE, "Advice for building Shiny apps in production",
  "00:31:20", FALSE, "Production apps is all about reproducibility: OS, dependencies, and the code.",
  "00:33:15", FALSE, "Pay attention to warning messages in your console.",
  "00:34:22", FALSE, "Modularization and Golem",
  "00:38:08", FALSE, "You can have too much reactivity, such as overextending uiOutput() / renderUI()",
  "00:40:10", FALSE, "Episode wrapup"
)

df2 <- gen_timestamps(df, youtube_id)

cat(df2$website_print, sep = "\n")
cat(df2$youtube_print, sep = "\n")