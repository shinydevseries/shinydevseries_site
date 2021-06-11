library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "84Vg7HKzd2E"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:06:15", FALSE, "Nick's journey since episode 5",
  "00:08:10", FALSE, "Shiny app stories - an experimental form of documentation. Most documentation focuses on the *How* to do something, Shiny App Stories focuses on the *Why*",
  "00:13:15", FALSE, "App Stories in action",
  "00:16:25", FALSE, "`bindCache()` discussion on speeding up your Shiny app",
  "00:22:57", FALSE, "Dynamic theming with `{bslib}`",
  "00:27:00", FALSE, "The usefulness of the `session` object in an Shiny app",
  "00:32:30", FALSE, "Including web-technologies (like custom js, css, incorporating better design philosiphies) in your Shiny app",
  "00:39:50", FALSE, "On the Shiny Ecosystem. Nick only recently moved from being an active Shiny developer to being on the core-Shiny team itself",
  "00:43:35", FALSE, "On Creating great data visualizations and offering data consumers an excellent user experience",
  "00:56:25", FALSE, "What's the best way to give feedback to the Shiny team?",
  "01:05:22", FALSE, "Episode wrapup"
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
  select(timestamp = new_time_print, youtube_time = new_time, description, youtube_minutes, youtube_seconds) %>%
  mutate(timestamp_print_clean = glue::glue("{timestamp}"),
         timestamp_print_link = glue::glue("[{timestamp_print_clean}](https://youtube.com/watch?v={youtube_id}&t={youtube_time}s)")) %>%
  mutate(website_print = glue::glue("{timestamp_print_link} {description}"),
         youtube_print = glue::glue("{timestamp_print_clean} {description}"))


cat(df2$website_print, sep = "\n")
cat(df2$youtube_print, sep = "\n")
