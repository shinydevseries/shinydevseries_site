# generate markdown and youtube text for timestamps
# setup: create a data frame with the time stamps using template
# supply the df as an argument alongside the video_id

# create template data frame and run function in script called
# timestamps_exec.R (which will not be version-controlled)

# example text for R/timestamps_exec.R

# library(dplyr)
# source("R/gen_timestamps.R")

# youtube_id <- "myid"
# df <- tibble::tribble(
#   ~timestamp, ~recalc_flag, ~description,
#   "00:00:00", FALSE, "Episode Introduction",
#   "00:03:00", FALSE, "Another Topic",
#   "00:40:00", FALSE, "Episode wrapup"
# )

# df2 <- gen_timestamps(df, youtube_id)
# cat(df2$website_print, sep = "\n")
# cat(df2$youtube_print, sep = "\n")

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
