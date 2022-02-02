---
title: "{{ replace .Name "-" " " | title }}" #Episode XX: Title
excerpt: "Short one-sentence summary"
date: {{ .Date }}
description: Add paragraph of episode description"
guests:
- flast #change to guest ID
draft: false
series:
tags:
categories:
youtube: XqLx233W97U # change ID for your video
aliases: /epXX # change XX to episode number
layout: single-sidebar
---
