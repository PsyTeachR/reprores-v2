# book-specific code to include on every page

# highlight inline R code
hl <- function(code) {
  txt <- rlang::enexpr(code) %>% rlang::as_label()
  downlit::highlight(txt, classes = downlit::classes_pandoc()) %>%
    paste0("<code>", . , "</code>")
}


embed_youtube <- function(url, width = 560, height = 315, border = 0) {
  sprintf("<iframe width=\"%s\" height=\"%s\" src=\"https://www.youtube.com/embed/%s\" frameborder=\"%s\" allowfullscreen></iframe>",
          width, height, url, border)
}

showtbl <- function(data, n = 6) {
  nm <- utils::capture.output(match.call()$data)
  if (n < nrow(data)) {
    cp <- sprintf("Rows 1-%s from `%s`", n, nm)
  } else {
    n <- nrow(data)
    cp <- sprintf("All rows from `%s`", nm)
  }
  
  data %>%
    ungroup() %>%
    slice(1:n) %>%
    knitr::kable(caption = cp)
}
