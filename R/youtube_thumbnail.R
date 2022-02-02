video_thumbnail <- function(video_id, episode) {
  # define file logistics
  episode_print <- sprintf("ep%03d", episode)
  episode_dir <- fs::path("content/interview/", episode_print)

  # define YouTube logistics
  thumb_file <- "hqdefault.jpg"
  url_template <- "https://img.youtube.com/vi/{video_id}/{thumb_file}"

  download.file(
    glue::glue(url_template, video_id = video_id, thumb_file = thumb_file),
    destfile = fs::path(episode_dir, "featured.jpg")
  )

  invisible(TRUE)
}