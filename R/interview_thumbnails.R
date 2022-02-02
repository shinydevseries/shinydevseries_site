# obtain thumbnail images for each interview post
int_dir <- "content/interview"
int_paths <- fs::dir_ls(int_dir, type = "directory")
#thumb_files <- c("default.jpg", "hqdefault.jpg", "maxresdefault.jpg")
thumb_file <- "hqdefault.jpg"

url_template <- "https://img.youtube.com/vi/{video_id}/{thumb_file}"
#https://img.youtube.com/vi/<insert-youtube-video-id-here>/maxresdefault.jpg
#https://img.youtube.com/vi/<insert-youtube-video-id-here>/default.jpg
#https://img.youtube.com/vi/<insert-youtube-video-id-here>/hqdefault.jpg

purrr::walk(int_paths, ~{
  message(glue::glue("processing {path}", path = .x))
  prev_header <- rmarkdown::yaml_front_matter(fs::path(.x, "index.md"))
  video_id <- prev_header$youtube
  interview_dir <- .x

  download.file(glue::glue(url_template, video_id = video_id, thumb_file = thumb_file), destfile = fs::path(interview_dir, "featured.jpg"))
  
  # purrr::walk(thumb_files, ~{
  #   download.file(glue::glue(url_template, video_id = video_id, thumb_file = .x), destfile = fs::path(interview_dir, .x))
  # })

})
