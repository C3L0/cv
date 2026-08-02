# Variables
TARGET = main_EN
PDF = $(TARGET).pdf
TEX = $(TARGET).tex
MODULES = $(wildcard modules/*.tex)

.PHONY: all clean check-pages

all: $(PDF) check-pages

$(PDF): $(TEX) $(MODULES)
	pdflatex -interaction=nonstopmode $(TEX)
	pdflatex -interaction=nonstopmode $(TEX)

# Enforces that the output PDF does not exceed 1 page
check-pages: $(PDF)
	@PAGES=$$(pdfinfo $(PDF) | grep Pages | awk '{print $$2}'); \
	if [ "$$PAGES" -gt 1 ]; then \
		echo "\033[0;31mERROR: Resume length is $$PAGES pages. Maximum allowed is 1 page.\033[0m"; \
		exit 1; \
	else \
		echo "\033[0;32mSUCCESS: Resume fits on 1 page.\033[0m"; \
	fi

clean:
	rm -f *.aux *.log *.out *.toc *.nav *.snm *.fls *.fdb_latexmk
