library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "QzmrhPmKByA"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:03:24", FALSE, "How David got started with R & Shiny",
  "00:05:40", FALSE, "Introduction to myPaintings",
  "00:24:15", FALSE, "Infinite scroll feature",
  "00:30:22", FALSE, "Design UI & UX of myPaintings",
  "00:34:15", FALSE, "User management & helper functions",
  "00:46:51", FALSE, "Overall app & file organization",
  "00:49:28", FALSE, "Using .values to store & update user state and environment",
  "00:53:40", FALSE, "R6 classes as another option",
  "01:00:20", FALSE, "Recap and conclusion"
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
