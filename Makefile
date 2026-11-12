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

thales:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Thales,fr,modules/fr/thales)

ibm:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_IBM,en,modules/en/ibm)

siemens:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Siemens,en,modules/en/siemens)

natixis:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Natixis,fr,modules/fr/natixis)

clickhouse:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Clickhouse,en,modules/en/clickhouse)

renault:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Renault,fr,modules/fr/renault)

pillar:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Pillar,en,modules/en/pillar)

mpdata: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_MPData,fr,modules/fr/mpdata)

showroomprive:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_ShowroomPrive,fr,modules/fr/showroomprive)

murphy: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Murphy,en,modules/en/murphy)

rothschild: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Rothschild,fr,modules/fr/rothschild)

eni: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Plenitude,en,modules/en/eni)

revolut: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Revolut,en,modules/en/revolut)

axa:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_AXA,fr,modules/fr/axa)

edf:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_EDF,fr,modules/fr/edf)

bnp:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_BNP,fr,modules/fr/bnp)

engie:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Engie,fr,modules/fr/engie)

bluetab:$(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Bluetab,en,modules/en/bluetab)

vanderlande: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Vanderlande,en,modules/en/vanderlande)

sage: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Sage,en,modules/en/sage)

temos: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_TemosAI,en,modules/en/temosai)

titanos: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_TitanOS,en,modules/en/titanos)

propelling: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_PropellingTech,en,modules/en/propelling_tech)

mane: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Mane,en,modules/en/mane)

wavegroup: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_WaveGroup,en,modules/en/wavegroup)

allianz: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Allianz,en,modules/en/allianz)

kering: $(PDF_DIR)
	$(call build_cv, CV_Antoine_Lopez_Kering,fr,modules/fr/kering)

afterdata: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_Afterdata,fr,modules/fr/afterdata)

thales: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_Thales,fr,modules/fr/thales)

thales_cortaix: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_Thales_cortAIx,fr,modules/fr/thales_cortaix)

kpler: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_Kpler,en,modules/en/kpler)

vw_hub: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_Volkswagen,en,modules/en/vw_hub)

linde: $(PDF_DIR)
	$(call build_cv,CV_Antoine_Lopez_Linde,en,modules/en/linde)

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
