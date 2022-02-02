library(blogdown)

# convert previous version of guest files to match new theme
# - title should be their name
# - author should be their name
# - layout should be "single-sidebar"
# - the old "organizations" should now become "links"
#   with icon = "link", icon_pack = "fas", name and url as the actual link
# - rename file name of image to "featured" (keep extension same)

prev_guest_dir <- "prototypng/guest"
new_guest_dir <- "content/guest"

# grab paths of directories in the prev guest dir
prev_guest_paths <- fs::dir_ls(prev_guest_dir, type = "directory")

purrr::walk(prev_guest_paths, ~{
  # import previous file header
  prev_header <- rmarkdown::yaml_front_matter(fs::path(.x, "_index.md"))
  prev_header$title <- prev_header$name
  prev_header$layout <- "single-sidebar"
  prev_header$links <- prev_header$organizations
  #print(prev_header$links)
  new_links <- prev_header$organizations

  # create new header to match theme archetype
  new_header <- list(
    draft = FALSE,
    excerpt = prev_header$role,
    layout = "single",
    links = new_links,
    social = prev_header$social,
    title = prev_header$title
  )

  # import markdown text after the yaml header
  raw_file <- readLines(fs::path(.x, "_index.md"), warn = FALSE)
  yaml_header_end <- grep("^---$", raw_file)[-1]

  markdown_text <- raw_file[(yaml_header_end + 2):length(raw_file)][1]

  # assemble new file contents
  header_convert <- yaml::as.yaml(new_header)

  # remove last newline character that exists for mysterious reasons
  header_convert <- stringr::str_replace(header_convert, "\\n$", "")

  writeLines(text = c("---", header_convert, "---\n", markdown_text), con = file(fs::path(.x, "index.md")))

  img_file <- fs::dir_ls(.x, type = "file", glob = "*.md", invert = TRUE)
  # file extension
  img_ext <- fs::path_ext(img_file)
  img_path <- fs::path_dir(img_file)
  new_img_file <- glue::glue("featured.{img_ext}")

  # rename image
  fs::file_copy(img_file, fs::path(img_path, new_img_file), overwrite = TRUE)
  
  # remove old image
  fs::file_delete(img_file)

  # remove old markdown file
  fs::file_delete(fs::path(.x, "_index.md"))

  # copy dir to new guest dir
  fs::dir_copy(.x, new_guest_dir)
})
