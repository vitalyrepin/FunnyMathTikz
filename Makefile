# Main input (w/o extension)
MAIN_FNAME=funnymath
# Additional files the main input file depends on
ADDDEPS=
IMAGES=

GOALS = $(MAIN_FNAME).pdf

COPY = if test -r $*.toc; then cp $*.toc $*.toc.bak; fi
RM = /bin/rm -f

all:            $(GOALS)

DEPS = 	$(MAIN_FNAME).tex $(ADDDEPS)


$(MAIN_FNAME).pdf: $(DEPS) $(IMAGES)


%.dvi:          %.tex
		latexmk $<

%.png:  %.dia
	dia -e $@ $<

%.png: %.pic
	pic2plot -T png $< > $@

%.ps: %.pic
	pic2plot -T ps $< > $@

%.eps: %.ps
	ps2eps $<

%.eps:  %.dia
	dia -e $@ $<

%.eps:  %.dot
	dot -Tps $< -o $@

%.pdf:  %.eps
	epstopdf $<

%.eps: %.png
	convert $< $@

%.pdf:          %.tex
		latexmk -pdf $<

clean:
		latexmk -c
		$(RM) -f *.bbl

