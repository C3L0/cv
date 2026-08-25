# Master Source Files
EN_SRC = main_EN.tex
FR_SRC = main_FR.tex

# Dependencies
MODULES_EN = $(wildcard modules/en/*.tex)
MODULES_FR = $(wildcard modules/fr/*.tex)

# Output Directory
PDF_DIR = output

# Generated PDFs (3 roles x 2 languages)
PDFS = \
	CV_Antoine_Lopez_ML_EN.pdf CV_Antoine_Lopez_ML_FR.pdf \
	CV_Antoine_Lopez_DE_EN.pdf CV_Antoine_Lopez_DE_FR.pdf \
	CV_Antoine_Lopez_SWE_EN.pdf CV_Antoine_Lopez_SWE_FR.pdf

# Prepend output directory to target paths
TARGETS = $(addprefix $(PDF_DIR)/, $(PDFS))

.PHONY: all clean check-pages ml de swe

all: $(PDF_DIR) $(TARGETS) check-pages

# Ensure output directory exists
$(PDF_DIR):
	mkdir -p $(PDF_DIR)

# --- Individual Profile Targets ---
ml: $(PDF_DIR) $(PDF_DIR)/CV_Antoine_Lopez_ML_EN.pdf $(PDF_DIR)/CV_Antoine_Lopez_ML_FR.pdf check-pages
de: $(PDF_DIR) $(PDF_DIR)/CV_Antoine_Lopez_DE_EN.pdf $(PDF_DIR)/CV_Antoine_Lopez_DE_FR.pdf check-pages
swe: $(PDF_DIR) $(PDF_DIR)/CV_Antoine_Lopez_SWE_EN.pdf $(PDF_DIR)/CV_Antoine_Lopez_SWE_FR.pdf check-pages

# --- Pattern Rules / Explicit Rules with Auto-Move ---

# English ML / DE / SWE
$(PDF_DIR)/CV_Antoine_Lopez_ML_EN.pdf: $(EN_SRC) $(MODULES_EN) | $(PDF_DIR)
	pdflatex -jobname=CV_Antoine_Lopez_ML_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(EN_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_ML_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(EN_SRC)}"
	mv CV_Antoine_Lopez_ML_EN.pdf $(PDF_DIR)/

$(PDF_DIR)/CV_Antoine_Lopez_DE_EN.pdf: $(EN_SRC) $(MODULES_EN) | $(PDF_DIR)
	pdflatex -jobname=CV_Antoine_Lopez_DE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(EN_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_DE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(EN_SRC)}"
	mv CV_Antoine_Lopez_DE_EN.pdf $(PDF_DIR)/

$(PDF_DIR)/CV_Antoine_Lopez_SWE_EN.pdf: $(EN_SRC) $(MODULES_EN) | $(PDF_DIR)
	pdflatex -jobname=CV_Antoine_Lopez_SWE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(EN_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_SWE_EN -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(EN_SRC)}"
	mv CV_Antoine_Lopez_SWE_EN.pdf $(PDF_DIR)/

# French ML / DE / SWE
$(PDF_DIR)/CV_Antoine_Lopez_ML_FR.pdf: $(FR_SRC) $(MODULES_FR) | $(PDF_DIR)
	pdflatex -jobname=CV_Antoine_Lopez_ML_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(FR_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_ML_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{true}\setbool{isDE}{false}\setbool{isSWE}{false}}\input{$(FR_SRC)}"
	mv CV_Antoine_Lopez_ML_FR.pdf $(PDF_DIR)/

$(PDF_DIR)/CV_Antoine_Lopez_DE_FR.pdf: $(FR_SRC) $(MODULES_FR) | $(PDF_DIR)
	pdflatex -jobname=CV_Antoine_Lopez_DE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(FR_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_DE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{true}\setbool{isSWE}{false}}\input{$(FR_SRC)}"
	mv CV_Antoine_Lopez_DE_FR.pdf $(PDF_DIR)/

$(PDF_DIR)/CV_Antoine_Lopez_SWE_FR.pdf: $(FR_SRC) $(MODULES_FR) | $(PDF_DIR)
	pdflatex -jobname=CV_Antoine_Lopez_SWE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(FR_SRC)}"
	pdflatex -jobname=CV_Antoine_Lopez_SWE_FR -interaction=nonstopmode "\PassOptionsToPackage{}{etoolbox}\AtBeginDocument{\setbool{isML}{false}\setbool{isDE}{false}\setbool{isSWE}{true}}\input{$(FR_SRC)}"
	mv CV_Antoine_Lopez_SWE_FR.pdf $(PDF_DIR)/

# --- Page-Limit Validation ---
check-pages: $(TARGETS)
	@for pdf in $(TARGETS); do \
		PAGES=$$(pdfinfo $$pdf | grep Pages | awk '{print $$2}'); \
		if [ "$$PAGES" -gt 1 ]; then \
			echo "\033[0;31mERROR: $$pdf is $$PAGES pages. Max allowed is 1.\033[0m"; \
			exit 1; \
		else \
			echo "\033[0;32mSUCCESS: $$pdf fits on 1 page.\033[0m"; \
		fi; \
	done

clean:
	rm -f *.aux *.log *.out *.toc *.nav *.snm *.fls *.fdb_latexmk
	rm -rf $(PDF_DIR)
