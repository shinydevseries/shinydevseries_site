---
title: "Episode 31: The Connecticut COVID-19 Test Spotter App (Part 2)" 
subtitle: "Mike Thomas returns to reveal the design principles and implementation of key features in the COVID-19 Test Spotter App!"
date: '2022-04-15'
description: The Shiny Developer Series continues our spotlight on the COVID-19 Test Spotter application created by renowned data scientist and entrepreneur Mike Thomas! In this episode we learn how Mike implemented robust database techniques and logic to manage user-supplied data, navigating the use of multiple mapping APIs, and achieving a practical development-to-production strategy for releasing the application to the public. Plus we have a great discussion on what production means in the space of Shiny development, and much more. 
guests:
- mthomas
draft: false
youtube: GdxVtl3FwmI
alias: 
  - /ep31
---

{{< video https://youtu.be/GdxVtl3FwmI >}}

## Resources mentioned in the episode

* COVID-19 At-Home Test Spotter (App) - [ketchbrookanalytics.shinyapps.io/covid_test_spotter](https://ketchbrookanalytics.shinyapps.io/covid_test_spotter/)
* COVID-19 At-Home Test Spotter (Code) - [github.com/ketchbrookanalytics/covid_test_spotter](https://github.com/ketchbrookanalytics/covid_test_spotter)
* App blog post - [www.ketchbrookanalytics.com/post/ketchbrook-analytics-launches-website-to-help-connecticut-residents-find-covid-19-test-kits](https://www.ketchbrookanalytics.com/post/ketchbrook-analytics-launches-website-to-help-connecticut-residents-find-covid-19-test-kits)
* `{googleWay}` Shiny vignette - [symbolixau.github.io/googleway/articles/googleway-vignette.html#shiny](https://symbolixau.github.io/googleway/articles/googleway-vignette.html#shiny)
* `{mongolite}` user manual - [jeroen.github.io/mongolite](https://jeroen.github.io/mongolite)
* `{reactable}` Interactive data tables for R - [glin.github.io/reactable](https://glin.github.io/reactable)

## Episode Timestamps

[00:00:00](https://youtube.com/watch?v=GdxVtl3FwmI&t=0s) Episode Introduction </br>
[00:00:46](https://youtube.com/watch?v=GdxVtl3FwmI&t=46s) CRUD workflow and flowchart, with MongoDB database updates </br>
[00:09:41](https://youtube.com/watch?v=GdxVtl3FwmI&t=581s) Diving into the Google Maps and Places API </br>
[00:15:55](https://youtube.com/watch?v=GdxVtl3FwmI&t=955s) Geographic fencing, and dealing with unexpected user behavior.  </br>
[00:22:35](https://youtube.com/watch?v=GdxVtl3FwmI&t=1355s) Deploying with a dev and production branch. </br>
[00:28:15](https://youtube.com/watch?v=GdxVtl3FwmI&t=1695s) Future plans for the app </br>
[00:30:50](https://youtube.com/watch?v=GdxVtl3FwmI&t=1850s) Advice for building Shiny apps in production </br>
[00:31:20](https://youtube.com/watch?v=GdxVtl3FwmI&t=1880s) Production apps is all about reproducibility: OS, dependencies, and the code. </br>
[00:33:15](https://youtube.com/watch?v=GdxVtl3FwmI&t=1995s) Pay attention to warning messages in your console. </br>
[00:34:22](https://youtube.com/watch?v=GdxVtl3FwmI&t=2062s) Modularization and Golem </br>
[00:38:08](https://youtube.com/watch?v=GdxVtl3FwmI&t=2288s) You can have too much reactivity, such as overextending uiOutput() / renderUI() </br>
[00:40:10](https://youtube.com/watch?v=GdxVtl3FwmI&t=2410s) Episode wrapup </br>

{{< include ../../_snippets/sessioninfo.qmd >}}
