library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "mxvMaoXOm70"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:01:17", TRUE, "What's new in RinteRface",
  "00:02:13", TRUE, "Demo of {bs4Dash}",
  "00:21:39", TRUE, "David's new book: Outstanding User Interfaces with Shiny",
  "00:35:45", TRUE, "Creating custom dashboard templates",
  "00:41:23", TRUE, "Moving away from renderUI using custom handlers, and why you should manage content with handlers",
  "00:44:20", TRUE, "Shiny UI advice, tips for balancing UX with backend performance of the app",
  "00:54:40", FALSE, "Episode wrapup"
)

df2 <- df %>%
  mutate(time2 = period_to_seconds(hms(timestamp)),
         new_time = if_else(recalc_flag,
                            time2 + period_to_seconds(hms("00:02:30")),
                            time2),
         new_time2 = lubridate::as_datetime(new_time),
         new_time_print = strftime(new_time2, format="%H:%M:%S"),
         youtube_minutes = minute(seconds_to_period(new_time)),
         youtube_seconds = new_time - (60 * youtube_minutes),
         youtube_seconds = if_else(youtube_seconds < 10,
                                   paste0("0", youtube_seconds),
                                   as.character(youtube_seconds))
         ) %>%
  select(., -timestamp) %>%
  select(timestamp = new_time_print, description, youtube_minutes, youtube_seconds) %>%
  mutate(timestamp_print_clean = glue::glue("{youtube_minutes}:{youtube_seconds}"),
         timestamp_print_link = glue::glue("[{timestamp_print_clean}](https://youtube.com/watch?v={youtube_id}&t={youtube_minutes}m{youtube_seconds}s)")) %>%
  mutate(website_print = glue::glue("{timestamp_print_link} {description}"),
         youtube_print = glue::glue("{timestamp_print_clean} {description}"))


cat(df2$website_print, sep = "\n")
