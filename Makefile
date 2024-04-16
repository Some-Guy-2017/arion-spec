.PHONY: all clean view

SRC_DIR := ./src
BUILD_DIR := ./build

TEX_FILE := $(wildcard ${SRC_DIR}/*.tex)
OUTPUT_FILES := $(TEX_FILE:${SRC_DIR}/%.tex=${BUILD_DIR}/%.pdf)

LATEX := pdflatex
LATEX_ARGS := -output-directory ${BUILD_DIR} -halt-on-error
PDF_VIEWER := zathura


all: ${BUILD_DIR} ${OUTPUT_FILES}

view: all
	${PDF_VIEWER} ${OUTPUT_FILES}

clean:
	rm -rf ${BUILD_DIR}

${BUILD_DIR}:
	mkdir ${BUILD_DIR}

${BUILD_DIR}/%.pdf: ${SRC_DIR}/%.tex
	${LATEX} ${LATEX_ARGS} $<
