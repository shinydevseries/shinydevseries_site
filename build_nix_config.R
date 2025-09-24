#https://gist.github.com/b-rodrigues/d427703e76a112847616c864551d96a1
library(rix)

rix(
  r_ver = "4.5.1",
  project_path = getwd(),
  r_pkgs = c(
    "rmarkdown",
    "knitr",
    "quarto",
    "yaml",
    "jsonlite",
    "rix",
    "shiny",
    "shinylive",
    "gfonts",
    "shinystate",
    "roxy.shinylive"
  ),
  system_pkgs = "quarto",
  ide = "none",
  overwrite = TRUE
)
