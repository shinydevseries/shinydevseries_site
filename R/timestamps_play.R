library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "wGfYYa1rfbg"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", TRUE, "Episode Introduction",
  "00:02:44", TRUE, "Appsilon, Shiny consulting",
  "00:07:44", TRUE, "The wonderful 'black magic' of Shiny",
  "00:09:50", TRUE, "Custom Shiny apps in the enterprise. Number one theme: migrating from excel",
  "00:17:40", TRUE, "Demo of Shiny app game Shiny Decisions",
  "00:22:50", TRUE, "A code walkthrough of Shiny Decisions",
  "00:32:50", TRUE, "On styling Shiny Decisions",
  "00:50:40", TRUE, "The value of learning a little javascript to improve your Shiny apps",
  "00:51:50", TRUE, "Book recommendations for integrating Javascript into your Shiny app and improving UI",
  "00:52:50", TRUE, "Pedro on `jQuery` for Shiny",
  "00:56:00", TRUE, "Advice for building Shiny apps in production",
  "01:10:00", TRUE, "Advice for people seeking a career in data science with R and Shiny"
)

df2 <- df %>%
  mutate(time2 = period_to_seconds(hms(timestamp)),
         new_time = if_else(recalc_flag,
                            time2 + period_to_seconds(hms("00:0:05")),
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
  select(timestamp = new_time_print, youtube_time = new_time, description, youtube_minutes, youtube_seconds) %>%
  mutate(timestamp_print_clean = glue::glue("{timestamp}"),
         timestamp_print_link = glue::glue("[{timestamp_print_clean}](https://youtube.com/watch?v={youtube_id}&t={youtube_time}s)")) %>%
  mutate(website_print = glue::glue("{timestamp_print_link} {description} <br> "),
         youtube_print = glue::glue("{timestamp_print_clean} {description}"))


cat(df2$website_print, sep = "\n")
cat(df2$youtube_print, sep = "\n")
