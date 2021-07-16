library(dplyr)
library(lubridate)
library(clock)

youtube_id <- "xTafvYX3zmE"

df <- tibble::tribble(
  ~timestamp, ~recalc_flag, ~description,
  "00:00:00", FALSE, "Episode Introduction",
  "00:02:00", FALSE, "Joining the Shiny team at RStudio and Carson's book on plotly",
  "00:06:39", FALSE, "Introducing bslib and how it makes custom theming of your Shiny app as easy as possible",
  "00:08:47", FALSE, "Introducing thematic for simplified theming of ggplot2, lattice, and base R graphics",
  "00:14:28", FALSE, "Getting started with bslib",
  "00:23:45", FALSE, "Real-time theming wizard, a tool to play interactively with the theming customization of your shiny app or R Markdown document",
  "00:29:25", FALSE, "Development version of flexdashboard supports bslib now",
  "00:36:38", FALSE, "On the advantages of working with sass over css. bslib helps you work with a front end web developer, writing sass rules and css styles while not having to dive into your Shiny app or R Markdown document",
  "00:46:30", FALSE, "The origins of shinymeta and the ability to fully extract an app's reactive processing to produce a fully self-contained analysis script or report",
  "00:57:40", FALSE, "Getting started with shinymeta",
  "01:01:20", FALSE, "Shinymeta example of producing reproducible Shiny code",
  "01:05:36", FALSE, "How does Carson recommend to Shiny developers who want to get better at cusotmizing the look and feel of their Shiny app? See Shiny’s Build articles",
  "01:15:35", FALSE, "Attaching metadata to graphical markers in plotly",
  "01:19:47", FALSE, "Episode wrapup"
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
  mutate(website_print = glue::glue("{timestamp_print_link} {description} <br> "),
         youtube_print = glue::glue("{timestamp_print_clean} {description}"))


cat(df2$website_print, sep = "\n")
cat(df2$youtube_print, sep = "\n")
