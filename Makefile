# Master Source Files
EN_SRC = main_EN.tex
FR_SRC = main_FR.tex

# Dependencies
MODULES_EN = $(wildcard modules/en/*.tex)
MODULES_FR = $(wildcard modules/fr/*.tex)

# Generated PDFs (3 roles x 2 languages = 6 targets)
PDFS = \
	CV_Antoine_Lopez_ML_EN.pdf CV_Antoine_Lopez_ML_FR.pdf \
	CV_Antoine_Lopez_DE_EN.pdf CV_Antoine_Lopez_DE_FR.pdf \
	CV_Antoine_Lopez_SWE_EN.pdf CV_Antoine_Lopez_SWE_FR.pdf

.PHONY: all clean check-pages ml de swe

all: $(PDFS) check-pages

# --- Individual Profile Targets (e.g. "make ml" or "make de") ---
ml: CV_Antoine_Lopez_ML_EN.pdf CV_Antoine_Lopez_ML_FR.pdf check-pages
de: CV_Antoine_Lopez_DE_EN.pdf CV_Antoine_Lopez_DE_FR.pdf check-pages
swe: CV_Antoine_Lopez_SWE_EN.pdf CV_Antoine_Lopez_SWE_FR.pdf check-pages

# --- Pattern Rules for Generating Specific Role PDFs ---

# English ML / DE / SWE
CV_Antoine_Lopez_ML_EN.pdf: $(EN_SRC) $(MODULES_EN)
	pdflatex -jobname=CV_Antoine_Lopez_ML_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(EN_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_ML_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(EN_SRC)}"

CV_Antoine_Lopez_DE_EN.pdf: $(EN_SRC) $(MODULES_EN)
	pdflatex -jobname=CV_Antoine_Lopez_DE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(EN_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_DE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(EN_SRC)}"

CV_Antoine_Lopez_SWE_EN.pdf: $(EN_SRC) $(MODULES_EN)
	pdflatex -jobname=CV_Antoine_Lopez_SWE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(EN_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_SWE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(EN_SRC)}"

# French ML / DE / SWE
CV_Antoine_Lopez_ML_FR.pdf: $(FR_SRC) $(MODULES_FR)
	pdflatex -jobname=CV_Antoine_Lopez_ML_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(FR_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_ML_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(FR_SRC)}"

CV_Antoine_Lopez_DE_FR.pdf: $(FR_SRC) $(MODULES_FR)
	pdflatex -jobname=CV_Antoine_Lopez_DE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(FR_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_DE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(FR_SRC)}"

CV_Antoine_Lopez_SWE_FR.pdf: $(FR_SRC) $(MODULES_FR)
	pdflatex -jobname=CV_Antoine_Lopez_SWE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(FR_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_SWE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(FR_SRC)}"

# --- Page-Limit Validation ---
check-pages:
	@for pdf in $(wildcard CV_*.pdf); do \
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
