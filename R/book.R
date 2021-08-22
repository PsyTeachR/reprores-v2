#' Open the Data Skills for Reproducible Research book
#'
#' @return NULL
#' @export
#'
book <- function() {
  file <- system.file("book", "index.html", package = "reprores")
  utils::browseURL(file)
}