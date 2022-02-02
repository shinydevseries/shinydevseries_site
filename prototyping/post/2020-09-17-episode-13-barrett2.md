---
aliases: /ep13
authors:
- bschloerke
- admin
- ckephart
categories:
- episode
date: "2020-09-17"
description: In episode 13 of the Shiny Developer Series, we continue our conversation with RStudio software engineer Barrett Schloerke to highlight how you can integrate Shiny apps with custom APIs written in R via the plumber package!  You’ll see awesome demonstrations of the key features that are part of the brand new plumber 1.0 release, including brand new serializers and parsers for custom objects, a new tidy API compliant with magrittr pipelines, utilizing asynchronous execution, and more.
image:
  caption: ""
  focal_point: ""
slug: episode-13-barrett2
summary: A tour of the massive new features in plumber 1.0!
tags: []
title: 'Episode 13: Inside Plumber 1.0 (Barret Schloerke Part 2)'
youtube: qOQMdtPdfU4
---

## Resources mentioned in the episode

* `plumber` allows you to create a web API by merely decorating your existing R source code with `roxygen2` style comments.
  * Site: https://www.rplumber.io/
  * Demos:
    * NEW - Hex logo and website!
    * NEW - pipe-able programatic interface
      * Demo: `plumb(dir = "plumber/pipe") %>% pr_run()`
    * NEW - POST body parsing
      * Process incoming POST body data
      * Ex: HTML forms, multipart forms, csv, tsv, json, yaml, feather and rds.
      * Like serializers, register new POST body parsers
      * Site: https://www.rplumber.io/reference/parsers.html
    * More Serializers!
      * Serialize outgoing route data
      * Ex: plain `text`, `json`, `yaml`, `csv`, `tsv`, `rds`, `feather`
      * NEW - Register image serializers: `svg`, `tiff`, `bmp`, `pdf`. (Pre existing: `png`, `jpeg`)
      * Site: https://www.rplumber.io/reference/serializers.html
    * NEW - Download return values as attachments!
      * Site: https://www.rplumber.io/reference/as_attachment.html
      * Demo: `plumb_api("plumber", "16-attachment") %>% pr_run()`
    * NEW - Async / promises
      * Demo: `plumb("plumber/plumber-future.R") %>% pr_run()`
    * NEW - API UIs (rapidoc)
      * Register new User Interfaces to look at your API
      * Demo: `plumb(dir = "plumber/rapidoc") %>% pr_run()`
  * Thank you to Bruno Tremblay (`@meztez`) for his heavy contributions to plumber!
* Recent conference talks about plumber:
  * Democratizing R with plumber APIs (James Blair): [rstudio.com/resources/rstudioconf-2019/democratizing-r-with-plumber-apis](https://rstudio.com/resources/rstudioconf-2019/democratizing-r-with-plumber-apis)
  * Practical plumber patterns  (James Blair): [rstudio.com/resources/rstudioconf-2020/practical-plumber-patterns/](https://rstudio.com/resources/rstudioconf-2020/practical-plumber-patterns/)
* Bike Prediction example application with plumber API and Shiny: [solutions.rstudio.com/tour/bike_predict/](https://solutions.rstudio.com/tour/bike_predict/)


## Episode Timestamps

0:00 - Intro

[1:14](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=1m14s) - Introduction to plumber 

[4:14](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=4m14s) - Example of plumber API

[7:14](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=7m14s) - Pipeable interface for plumber

[9:19](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=9m19s) - plumber's new hex logo! 

[9:24](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=9m24s) - Serializers in plumber

[13:04](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=13m04s) - Parsers in plumber

[14:30](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=14m30s) - `as_attachment` for serializers

[15:50](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=15m50s) - Demo of downloading an attachment from API

[16:07](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=16m07s) - A consistent way to check for plumber APIs with `available_apis()`

[18:50](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=18m50s) - Async processing in plumber

[24:23](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=24m23s) - Demo of the plumber documentation UI

[29:20](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=29m20s) - Example of decoupling data source from Shiny app

[29:50](https://www.youtube.com/watch?v=qOQMdtPdfU4&t=29m50s) - Episode wrapup
