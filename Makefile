# Master Source Files
SRC = main.tex
PDF_DIR = output
LATEX_CMD = pdflatex -interaction=nonstopmode -halt-on-error

# ==============================================================================
# Reusable Build Template:
# $(call build_cv,target_name,language,module_subpath,[optional_toggles])
# ==============================================================================
define build_cv
	@echo "\033[1;34m==> Compiling $(1) [$(2)] from $(3)...\033[0m"
	$(LATEX_CMD) -jobname="$(1)" '\newif\ifisML\newif\ifisDE\newif\ifisSWE$(4)\newcommand{\lang}{$(2)}\newcommand{\modulepath}{$(3)}\input{$(SRC)}'
	$(LATEX_CMD) -jobname="$(1)" '\newif\ifisML\newif\ifisDE\newif\ifisSWE$(4)\newcommand{\lang}{$(2)}\newcommand{\modulepath}{$(3)}\input{$(SRC)}'
	@mv "$(1).pdf" $(PDF_DIR)/
	@PAGES=$$(pdfinfo $(PDF_DIR)/"$(1).pdf" | grep Pages | awk '{print $$2}'); \
	if [ "$$PAGES" -gt 1 ]; then \
		echo "\033[0;31mERROR: $(PDF_DIR)/$(1).pdf has $$PAGES pages. Max allowed is 1.\033[0m"; \
		exit 1; \
	else \
		echo "\033[0;32mSUCCESS: $(PDF_DIR)/$(1).pdf generated (1 page).\033[0m"; \
	fi
endef

# ==============================================================================
# Phony Targets
# ==============================================================================
.PHONY: all clean ml de swe thales thales_cortaix criteo lvmh cohere happyrobot margo margo_mle vw_hub linde kpler afterdata

$(PDF_DIR):
	@mkdir -p $(PDF_DIR)

# Default: compile generic targets
all: $(PDF_DIR) ml de swe

# ==============================================================================
# Company / Specific Job Targets (Single-line syntax)
# ==============================================================================

# company:$(PDF_DIR)
# 	$(call build_cv, CV_Antoine_Lopez_Company,<en/fr>,modules/<en/fr>/company)

# ==============================================================================
# Generic Role Targets (Toggle respective boolean flag in $(4))
# ==============================================================================
ml: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_ML_EN,en,modules/en,\isMLtrue)
	$(call build_cv,CV_Antoine_Lopez_ML_FR,fr,modules/fr,\isMLtrue)

de: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_DE_EN,en,modules/en,\isDEtrue)
	$(call build_cv,CV_Antoine_Lopez_DE_FR,fr,modules/fr,\isDEtrue)

swe: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_SWE_EN,en,modules/en,\isSWEtrue)
	$(call build_cv,CV_Antoine_Lopez_SWE_FR,fr,modules/fr,\isSWEtrue)

# ==============================================================================
# Clean
# ==============================================================================
clean:
	@rm -f *.aux *.log *.out *.toc *.nav *.snm *.fls *.fdb_latexmk *.synctex.gz
	@rm -rf $(PDF_DIR)
	@echo "\033[0;32mBuild artifacts and output directory cleaned.\033[0m"
