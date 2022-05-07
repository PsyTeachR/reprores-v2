# knit all exercise and answer Rmd files
input <- list.files("book/exercises", "\\.Rmd", full.names = TRUE)
purrr::map(input, rmarkdown::render, quiet = TRUE)

# zip exercises files
f.zip <- list.files("book/exercises", "*_exercise.Rmd", full.names = TRUE)
#d.zip <- list.files("book/exercises/data", full.names = TRUE)
zipfile <- "book/exercises/exercises.zip"
if (file.exists(zipfile)) file.remove(zipfile)
zip(zipfile, c(f.zip), flags = "-j")

# render the book ----

## make PDF ----
set.seed(8675309)
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::pdf_book"))
)
file.remove("docs/reprores-v2.pdf")
file.rename("docs/_main.pdf", "docs/reprores-v2.pdf")

## make EPUB ----
set.seed(8675309)
xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::epub_book"))
file.remove("docs/reprores-v2.epub")
file.rename("docs/_main.epub", "docs/reprores-v2.epub")

## make MOBI ----
epub <- file.path(getwd(), "docs/reprores-v2.epub")
# requires the command line tools from calibre
ebook_convert <- "/Applications/calibre.app/Contents/MacOS/ebook-convert"
if (file.exists(epub) & file.exists(ebook_convert)) {
  mobi <- gsub(".epub$", ".mobi", epub)
  if (file.exists(mobi)) file.remove(mobi)
  system(paste(ebook_convert, epub, mobi))
}

## make html ----
set.seed(8675309)
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::bs4_book"))
)


#browseURL(xfun::in_dir("book", bookdown::preview_chapter("04-data.Rmd", output = "bookdown::bs4_book")))

# copies dir
R.utils::copyDirectory(
  from = "docs",
  to = "inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)

unlink("inst/book/.nojekyll") # causes package warning
