include DocInfos.mk

SLANG=\\usepackage[$(LANG)]{babel}
ifneq (, $(findstring french, $(LANG)))
	SLANG+=\n\\usepackage[T1]{fontenc}
endif

SFONT=
ifneq ($(FONT), default)
	SFONT=\usepackage{$(FONT)}
endif

TEXPATH=./tex
# used in sed script, hence the back-slash
# also, note that since pdflatex is runned from ./tmp, the relative path to pics
# is ../pics and not ./pics
PIXPATH=..\/pics
TMPPATH=./tmp

HEADER_PATTERN=header.tex
HEADER_CUSTOM= $(TMPPATH)/$(HEADER_PATTERN)

TEXFILES= $(HEADER_CUSTOM) $(wildcard $(TEXPATH)/*.tex)

LATEX=latex -shell-escape
PDF=pdflatex -shell-escape
DVIPDF=dvipdf

CP=@cp -v
RM=-@rm -rfv
MV=@mv -v
MKDIR=mkdir -p
ECHO=@echo

all: $(FILE).pdf

# generate a pdf file from the big tex file and then moves it at the root
$(FILE).pdf: $(TMPPATH)/$(FILE).tex
	$(ECHO) "*** Generating pdf file... ***"
	cd $(TMPPATH); $(PDF) $(<F); \
	if test -e $(FILE).toc;\
		then $(PDF) $(<F);\
	fi; cd -
	$(MV) $(TMPPATH)/$(FILE).pdf $(FILE).pdf
	$(ECHO) "*** pdf file generated. ***"

# concatenate every tex files in the list to the big tex file
$(TMPPATH)/$(FILE).tex: $(TEXFILES) | $(TMPPATH)/
	$(ECHO) Texfiles : $(TEXFILES)
	$(foreach tex, $(TEXFILES), cat $(tex) >> $(@).tmp;)
	$(ECHO) "\\end{document}" >> $(@).tmp

	$(MV) $(@).tmp $(@)

# parse the header pattern and replace in it placeholders with defined variables
# in DocInfo.mk
$(HEADER_CUSTOM): $(HEADER_PATTERN) DocInfos.mk | $(TMPPATH)/
	$(CP) $< $@.tmp
# replace occurences of $TITLE, $AUTHOR, $OBJECT
	sed -i 's/\$$AUTHOR/$(AUTHOR)/' $@.tmp
	sed -i 's/\$$TITLE/$(TITLE)/' $@.tmp
	sed -i 's/\$$OBJECT/$(OBJECT)/' $@.tmp
# replace occurences of $PIXPATH
	sed -i 's/\$$PIXPATH/$(PIXPATH)/' $@.tmp
# replace occurences of DCLASS
	sed -i 's/\$$DCLASS/$(DCLASS)/' $@.tmp
# replace occurences of $FRULE, $HRULE
	sed -i 's/\$$FRULE/$(FRULE)/' $@.tmp
	sed -i 's/\$$HRULE/$(HRULE)/' $@.tmp
# insert the OTHER_OPTIONS
	sed -i 's/\$$OTHER_OPTIONS/$(OTHER_OPTIONS)/' $@.tmp

	$(ECHO) $(SLANG)
	sed -i 's/\$$LANG/$(SLANG)/' $@.tmp

	sed -i 's/\$$FONT/$(SFONT)/' $@.tmp

	$(MV) $@.tmp $@

$(TMPPATH)/:
	$(MKDIR) $@

re: clean all

cleanall: clean
	$(ECHO) "*** Cleaning everything ***"
	$(RM) $(FILE).pdf
	$(ECHO) "*** Done. ***"

clean:
	$(ECHO) "*** Cleaning all but final pdf file ***"
	$(RM) $(TMPPATH)
	$(ECHO) "*** Done. ***"

