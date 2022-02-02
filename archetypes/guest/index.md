---
title: "{{ replace .Name "-" " " | title }}" # Guest name
excerpt: Occupation # short label for guest's occupation
date: {{ .Date }}
draft: false
series:
tags:
categories:
layout: single # single or single-sidebar
social: # change these to match guest's social links
- icon: twitter
  icon_pack: fab
  url: https://twitter.com/shinydevseries
- icon: github
  icon_pack: fab
  url: https://github.com/rpodcast
- icon: linkedin
  icon_pack: fab
  url: https://linkedin.com
links: #customize as appropriate
- icon: door-open
  icon_pack: fas
  name: website
  url: https://shinydevseries.com
---
