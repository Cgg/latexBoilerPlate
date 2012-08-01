include DocInfos.mk

TEXPATH=./tex
PIXPATH=./pics
TMPPATH=./tmp

HEADER_PATTERN=header.tex
HEADER_CUSTOM= $(TMPPATH)/$(HEADER_PATTERN)

TEXFILES= $(HEADER_CUSTOM) $(wildcard $(TEXPATH)/*.tex)

LATEX=latex -shell-escape
PDF=pdflatex -shell-escape
DVIPDF=dvipdf

RM=-rm -rfv
MV=mv -v
MKDIR=mkdir -p
ECHO=@echo

all: $(FILE).pdf

# generate a pdf file from the big tex file and then moves it at the root
$(FILE).pdf: $(TMPPATH)/$(FILE).tex | $(TMPPATH)/
	$(ECHO) "*** Generating pdf file... ***"
	$(PDF) $<
	if test -e $(TMPPATH)/*.toc;\
		then $(PDF) $<;\
	fi
	$(MV) $(TMPPATH)/$(FILE).pdf $(FILE).pdf
	$(ECHO) "*** pdf file generated. ***"

# concatenate every tex files in the list to the big tex file
$(TMPPATH)/$(FILE).tex: $(TEXFILES)
	$(foreach tex, $<, cat $(tex) >> $(@).tmp;)
	$(MV) $(@).tmp $(@)

# parse the header pattern and replace in it placeholders with defined variables
# in DocInfo.mk
$(HEADER_CUSTOM): $(HEADER_PATTERN) DocInfos.mk

$(TMPDIR)/:
	$(MKDIR) $@

re: clean all

#dvi: tex
	#${ECHO} "	*** Generating dvi file... ***"
	#${LATEX} *.tex
	#if test -e *.toc;\
	#then ${LATEX} *.tex;\
	#fi
	#${ECHO} "	*** dvi file generated. ***"

#dvipdf: dvi
	#${ECHO} "	*** Generating pdf file... ***"
	#${DVIPDF} *.dvi
	#${ECHO} "	*** pdf file generated. ***"
	
cleanall: clean
	$(ECHO) "*** Cleaning everything ***"
	$(RM) $(FILE).pdf
	$(ECHO) "	*** Done. ***"

clean:
	$(ECHO) "*** Cleaning all but final pdf file ***"
	$(RM) $(TMPPATH)
	$(ECHO) "	*** Done. ***"

