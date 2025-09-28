#!/bin/nu
pdflatex proceedings.tex
bibtex proceedings
pdflatex proceedings.tex
pdflatex proceedings.tex
mv proceedings.pdf ./out/proceedings.pdf

