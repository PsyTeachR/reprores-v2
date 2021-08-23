# knit all exercise and answer Rmd files
input <- list.files("book/exercises", "*.Rmd", full.names = TRUE)
purrr::map(input, rmarkdown::render, quiet = TRUE)

# zip exercises files
f.zip <- list.files("book/exercises", "*_exercise.Rmd", full.names = TRUE)
#d.zip <- list.files("book/exercises/data", full.names = TRUE)
zipfile <- "book/exercises/exercises.zip"
if (file.exists(zipfile)) file.remove(zipfile)
zip(zipfile, c(f.zip), flags = "-j")

# render the book ----

## make PDF ----
of <- bookdown::pdf_book()
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", of))
)
file.remove("docs/reprores-v2.pdf")
file.rename("docs/_main.pdf", "docs/reprores-v2.pdf")

## make EPUB ----
of <- bookdown::epub_book()
xfun::in_dir("book", bookdown::render_book("index.Rmd", of))
file.remove("docs/reprores-v2.epub")
file.rename("docs/_main.epub", "docs/reprores-v2.epub")

## make MOBI ----
file.remove("docs/reprores-v2.mobi")
system("/Applications/calibre.app/Contents/MacOS/ebook-convert ~/rproj/psyteachr/reprores-v2/docs/reprores-v2.epub ~/rproj/psyteachr/reprores-v2/docs/reprores-v2.mobi")

## make html ----
of <- bookdown::gitbook(split_bib = FALSE)
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", of))
)


#browseURL(xfun::in_dir("book", bookdown::preview_chapter("00-intro.Rmd")))

# copies dir
R.utils::copyDirectory(
  from = "docs",
  to = "inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)

unlink("inst/book/.nojekyll") # causes package warning
