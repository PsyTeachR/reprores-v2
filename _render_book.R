# knit all exercise and answer Rmd files
input <- list.files("book/exercises", "*.Rmd", full.names = TRUE)
purrr::map(input, rmarkdown::render, quiet = TRUE)

# zip exercises files
f.zip <- list.files("book/exercises", "*_exercise.Rmd", full.names = TRUE)
#d.zip <- list.files("book/exercises/data", full.names = TRUE)
zipfile <- "book/exercises/exercises.zip"
if (file.exists(zipfile)) file.remove(zipfile)
zip(zipfile, c(f.zip), flags = "-j")

# render the book
browseURL(
  xfun::in_dir("book", bookdown::render_book())
)

#browseURL(xfun::in_dir("book", bookdown::preview_chapter("00-intro.Rmd")))

# copies dir
R.utils::copyDirectory(
  from = "docs",
  to = "inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)

unlink("inst/book/.nojekyll") # causes package warning
