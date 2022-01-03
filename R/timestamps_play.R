library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "8crXv5SBDLE"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:01:00", FALSE, "The vueR package and introductory examples",
  "00:06:55", FALSE, "Live coding example with vuetify",
  "00:13:55", FALSE, "vueR example, adding a calendar date selector and other mint-ui elements to your Shiny app",
  "00:21:00", FALSE, "htmlwidget leaflet map example",
  "00:24:10", FALSE, "Example of a sunburst plot",
  "00:33:15", FALSE, "Example of a checkbox selector for hierarchical element trees",
  "00:36:00", FALSE, "JavaScript build steps with Vue CLI",
  "00:59:30", FALSE, "vite vue 3 build example",
  "01:09:30", FALSE, "A call to the community to help with vueR development goals",
  "01:10:30", FALSE, "Integrating crosstalk",
  "01:14:30", FALSE, "Using vuex as a store of state. Time travel through the state of your Shiny app",
  "01:20:24", FALSE, "Example of valtio",
  "01:27:08", FALSE, "Episode wrapup"
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
