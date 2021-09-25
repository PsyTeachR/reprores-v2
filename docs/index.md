--- 
title: Data Skills for Reproducible Research
subtitle: v2
authors: "Lisa DeBruine & Dale Barr"
date: "2021-09-25"
site: bookdown::bookdown_site
documentclass: book
classoption: oneside # for PDFs
geometry: margin=1in # for PDFs
bibliography: [book.bib, packages.bib]
csl: include/apa.csl
link-citations: yes
description: |
    This book provides an overview of skills needed for reproducible research and open science using the statistical programming language R and tidyverse packages. It covers data visualisation, data tidying and wrangling, archiving, iteration and functions, probability and data simulations, general linear models, and reproducible workflows.
url: "https://psyteachr.github.io/reprores-v2"
github-repo: "psyteachr/reprores-v2"
cover-image: "images/logos/logo.png"
apple-touch-icon: "images/logos/apple-touch-icon.png"
apple-touch-icon-size: 180
favicon: "images/logos/favicon.ico"
---

# Overview {-}

<div class="small_right"><img src="images/logos/logo.png" alt="Hex sticker, blue, text: Repro Res" /></div>

This book provides an overview of skills needed for reproducible research and open science using the statistical programming language R and tidyverse packages. It covers data visualisation, data tidying and wrangling, archiving, iteration and functions, probability and data simulations, general linear models, and reproducible workflows.


The book is also available in [PDF](reprores-v2.pdf), [ePub](reprores-v2.epub) and [Kindle](reprores-v2.mobi) formats, but these may have odd formatting where the onlne book has interactive elements like quizzes and shiny apps.


## Resources {-}

* [Data Skills Videos](https://www.youtube.com/playlist?list=PLA2iRWVwbpTKqULIFGBIe4Bg-YounTV1J){target="_blank"}
    Each chapter has several short video lectures for the main learning outcomes. The videos are captioned and watching with the captioning on is a useful way to learn the jargon of computational reproducibility. If you cannot access YouTube, the videos are available by request.

* [reprores](https://github.com/psyteachr/reprores-v2){target="_blank"}
    This is a custom R package for this course. You can install it with the code below. It will download all of the packages that are used in the book, along with an offline copy of this book, the shiny apps used in the book, and the exercises.
    
    
    ```r
    devtools::install_github("psyteachr/reprores-v2")
    ```

* [glossary](https://psyteachr.github.io/glossary){target="_blank"}
    Coding and statistics both have a lot of specialist terms. Throughout this book, jargon will be linked to the glossary.
    
## How to learn data skills {-}

<div class="left meme"><img src="images/memes/gym_sleep.jpg" 
    alt="top text: Me: gonna get to the gym early today, set myself on a regimen, get gains. Also me:; Photo: Man sleeping on gym equipment" /></div>

Learning data skills is kind of like having a gym membership (HT to [Phil McAleer](https://twitter.com/McAleerP) for the analogy). You'll be given state-of-the-art equipment to use and instructions for how to use them, but your data skills won't get any stronger unless you practice. 

Data skills do not require you to memorise lots of code. You will be introduced to many different functions, but the main skill to learn is how to efficiently find the information you need. This will require getting used to the structure of help files and [cheat sheets](https://www.rstudio.com/resources/cheatsheets/){target="_blank"}, learning how to Goggle your problem and choose a helpful solution, and learning how to read error messages.

<div class="right meme"><img src="images/memes/changing-stuff.jpg" 
     alt="Fake O'Reilly-style book cover, line drawing of a kitten; title: Changing Stuff and Seeing What Happens; top text: How to actually learn any new programming concept" /></a></div>

Learning to code involves making a **lot** of mistakes. These mistakes are completely essential to the process, so try not to feel too frustrated. Many of the chapter exercises will give you broken code to fix so you get experience seeing what common errors look like. As you become a more experienced coder, you might not make fewer errors, but you'll recover from them much faster.

## I found a bug! {-}

This book is a work in progress, so you might find errors. Please help me fix them! The best way is to open an [issue on github](https://github.com/PsyTeachR/reprores-v2/issues){target="_blank"} that describes the error, but you can also [email Lisa](mailto:lisa.debruine@glasgow.ac.uk?subject=reprores).

## Other Resources {-}

- [RStudio Cheat Sheets](https://www.rstudio.com/resources/cheatsheets/) 
- [Improving Pedagogy through Registered Reports](https://psyarxiv.com/q34k8)
- [Learning Statistics with R](https://learningstatisticswithr-bookdown.netlify.com) by Navarro
- [R for Data Science](http://r4ds.had.co.nz) by Grolemund and Wickham
- [Improving your statistical inferences](https://www.coursera.org/learn/statistical-inferences/) on Coursera
- [swirl](http://swirlstats.com)
- [R for Reproducible Scientific Analysis](http://swcarpentry.github.io/r-novice-gapminder/)
- [codeschool.com](http://tryr.codeschool.com)
- [datacamp](https://www.datacamp.com/courses/free-introduction-to-r)
- [Style guide for R programming](http://style.tidyverse.org)
- [#rstats on twitter](https://twitter.com/search?q=%2523rstats) highly recommended!


