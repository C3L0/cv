# Target master files
EN_TARGET = main_EN
FR_TARGET = main_FR

EN_PDF = CV_Antoine_Lopez_EN.pdf
FR_PDF = CV_Antoine_Lopez_FR.pdf

.PHONY: all clean check-pages

all: $(EN_PDF) $(FR_PDF) check-pages

$(EN_PDF): $(EN_TARGET).tex $(wildcard modules/en/*.tex)
	pdflatex -jobname=$(basename $(EN_PDF)) -interaction=nonstopmode $(EN_TARGET).tex
	pdflatex -jobname=$(basename $(EN_PDF)) -interaction=nonstopmode $(EN_TARGET).tex

$(FR_PDF): $(FR_TARGET).tex $(wildcard modules/fr/*.tex)
	pdflatex -jobname=$(basename $(FR_PDF)) -interaction=nonstopmode $(FR_TARGET).tex
	pdflatex -jobname=$(basename $(FR_PDF)) -interaction=nonstopmode $(FR_TARGET).tex

check-pages:
	@for pdf in $(EN_PDF) $(FR_PDF); do \
		PAGES=$$(pdfinfo $$pdf | grep Pages | awk '{print $$2}'); \
		if [ "$$PAGES" -gt 1 ]; then \
			echo "\033[0;31mERROR: $$pdf is $$PAGES pages. Max allowed is 1.\033[0m"; \
			exit 1; \
		else \
			echo "\033[0;32mSUCCESS: $$pdf fits on 1 page.\033[0m"; \
		fi; \
	done

clean:
	rm -f *.aux *.log *.out *.toc *.nav *.snm *.fls *.fdb_latexmk *.pdf
