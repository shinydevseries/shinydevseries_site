---
author: Eric Nantz
date: "2025-09-18"
draft: false
excerpt: Edit later
layout: single
tags:
- shinystate
title: shinystate 0.1.0 is available on CRAN!
---

I am extremely thrilled to announce that my new package `{shinystate}` is now available on CRAN! The `{shinystate}` package enables powerful customization of the built-in Shiny bookmarkable state feature.

You can install the package from CRAN with the following command:

```r
install.packages("shinystate")
```

## Why `shinystate`?

In 2016, version 0.14 of Shiny introducted a new feature called [bookmarkable state](https://shiny.posit.co/r/articles/share/bookmarking-state/), enabling Shiny applications to save and restore the state of application input values and optionally reactive values. I was an early adopter of this feature, and it was very helpful for my applications with a relatively small number of inputs and outputs. As my production-grade applications grew in complexity, I encountered a few limitations:

* The URL method of recording application state (where the input parameters are encoded inside the application URL address) would surpass the length of a URL allowed in a web browser's address bar.
* When moving to the server method of recording application state (where the state of the application is saved to disk via custom `rds` objects), these state files where saved to a location within the hosting server's installation of Shiny Server (later Posit Connect) that only an administrator of that platform could access.



