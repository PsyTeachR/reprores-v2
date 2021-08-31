# knit all exercise and answer Rmd files
input <- list.files("book/exercises", "02_.*\\.Rmd", full.names = TRUE)
purrr::map(input, rmarkdown::render, quiet = TRUE)

# zip exercises files
f.zip <- list.files("book/exercises", "*_exercise.Rmd", full.names = TRUE)
#d.zip <- list.files("book/exercises/data", full.names = TRUE)
zipfile <- "book/exercises/exercises.zip"
if (file.exists(zipfile)) file.remove(zipfile)
zip(zipfile, c(f.zip), flags = "-j")

# render the book ----

## make PDF ----
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::pdf_book"))
)
file.remove("docs/reprores-v2.pdf")
file.rename("docs/_main.pdf", "docs/reprores-v2.pdf")

## make EPUB ----
xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::epub_book"))
file.remove("docs/reprores-v2.epub")
file.rename("docs/_main.epub", "docs/reprores-v2.epub")

## make MOBI ----
file.remove("docs/reprores-v2.mobi")
system("/Applications/calibre.app/Contents/MacOS/ebook-convert ~/rproj/psyteachr/reprores-v2/docs/reprores-v2.epub ~/rproj/psyteachr/reprores-v2/docs/reprores-v2.mobi")

## make html ----
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::bs4_book"))
)


#browseURL(xfun::in_dir("book", bookdown::preview_chapter("02-repro.Rmd", output = "bookdown::bs4_book")))

# copies dir
R.utils::copyDirectory(
  from = "docs",
  to = "inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)

unlink("inst/book/.nojekyll") # causes package warning
