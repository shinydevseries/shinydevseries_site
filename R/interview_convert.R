library(blogdown)

# convert previous version of guest files to match new theme
# - title should be their name
# - author should be their name
# - layout should be "single-sidebar"
# - the old "organizations" should now become "links"
#   with icon = "link", icon_pack = "fas", name and url as the actual link
# - rename file name of image to "featured" (keep extension same)

prev_dir <- "prototyping/post"
new_dir <- "content/interview"

# grab paths of files in the previous interviews dir
prev_paths <- fs::dir_ls(prev_dir, type = "file")

purrr::walk(prev_paths, ~{
  # import previous file header
  message(glue::glue("processing {path}", path = .x))
  prev_header <- rmarkdown::yaml_front_matter(.x)

  # obtain guest from the episode
  guests <- prev_header$authors

  if (length(guests) == 1) {
    if (guests == "admin") {
      guests <- ""
    }
  } else {
    guests <- guests[!guests %in% c("admin", "ckephart")]
  }
  
  # create new header to match theme archetype
  new_header <- list(
    draft = FALSE,
    excerpt = prev_header$summary,
    layout = "single-series",
    title = prev_header$title,
    date = prev_header$date,
    description = prev_header$description,
    guests = guests,
    youtube = prev_header$youtube
  )

  # import markdown text after the yaml header
  raw_file <- readLines(.x, warn = FALSE)
  yaml_header_end <- grep("^---$", raw_file)[-1]

  markdown_text <- raw_file[(yaml_header_end + 2):length(raw_file)]

  # assemble new file contents
  header_convert <- yaml::as.yaml(new_header)

  # remove last newline character that exists for mysterious reasons
  header_convert <- stringr::str_replace(header_convert, "\\n$", "")

  # create directory for episode in the new dir
  episode_number <- as.numeric(gsub(".*?([0-9]+).*", "\\1", prev_header$slug))

  episode_print <- sprintf("ep%03d", episode_number)

  episode_dir <- fs::dir_create(fs::path(new_dir, episode_print))

  writeLines(text = c("---", header_convert, "---\n", markdown_text), con = file(fs::path(episode_dir, "index.md")))
})
