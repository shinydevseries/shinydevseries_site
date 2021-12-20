library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "SkFLHbHrPD4"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:01:00", FALSE, "Introduction to Herman Sontrop",
  "00:06:10", FALSE, "Introduction to Kenton Russell",
  "00:10:00", FALSE, "High-level walkthrough of Movie Vue R",
  "00:19:25", FALSE, "Diving into the code that drives Movie Vue R",
  "00:22:35", FALSE, "Overview and motivation behind Vue",
  "00:38:30", FALSE, "Vue instance example",
  "00:40:00", FALSE, "Vue reactivty examples",
  "00:46:10", FALSE, "Vue.js components are like Shiny modules",
  "00:49:50", FALSE, "Single file components",
  "00:54:16", FALSE, "Breaking down a Vue component into useful parts; props, data, methods, computed, and watch",
  "00:57:20", FALSE, "Vuetify, tap into many pre-built components, styles, and more",
  "01:10:00", FALSE, "Covid Globe Example in Shiny app",
  "01:12:40", FALSE, "Rendering a ggplot",
  "01:15:15", FALSE, "Summarizing parts of the Movie Vue R app",
  "01:19:10", FALSE, "A look at template.html. A detailed walk through the organization of the app's HTML and files",
  "01:26:30", FALSE, "Where R and Shiny are added to a Vue app. And how your app can send messages back to Shiny and R",
  "01:31:20", FALSE, "Loading images and ggplots",
  "01:38:00", FALSE, "Episode wrapup"
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
