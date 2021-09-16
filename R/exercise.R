#' Get an exercise
#'
#' @param chapter The chapter that the exercise is for
#' @param filename What filename you want to save (defaults to the name of the chapter)
#' @param answers Whether or not you want the answers
#'
#' @return Saves a file to the working directory (or path from filename)
#' @export
#'
exercise <- function(chapter, filename = NULL, answers = FALSE) {
  pattern <- sprintf("%s%s%s.*_%s\\.Rmd", 
                     ifelse(is.numeric(chapter), "^0?", ".*"),
                     chapter,
                     ifelse(is.numeric(chapter), "_", ""),
                     ifelse(answers, "answers", "exercise"))
  dir <- system.file("book/exercises", package = "reprores")
  
  f <- list.files(dir, pattern)
  
  if (length(f) != 1) stop("Exercise ", chapter, " doesn't exist")
  
  if (is.null(filename)) filename <- f
  
  file.copy(file.path(dir, f), filename)
  
  #open file for editing
  if(rstudioapi::hasFun("navigateToFile")){
    rstudioapi::navigateToFile(filename)
  }
}
