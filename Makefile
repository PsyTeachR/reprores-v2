.PHONY : book
book :
	Rscript -e 'xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::bs4_book"))'

bookpdf :
	Rscript -e 'xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::pdf_book"))'

bookepub :
	Rscript -e 'xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::epub_book"))'
