.PHONY: all clean view

SRC_DIR := ./src/
SRC_BACKUP := ./.src-backup/
BUILD_DIR := ./build/

TEX_FILE := $(wildcard ${SRC_DIR}/*.tex)
OUTPUT_FILES := $(TEX_FILE:${SRC_DIR}/%.tex=${BUILD_DIR}/%.pdf)

LATEX := pdflatex
LATEX_ARGS := -output-directory ${BUILD_DIR} -halt-on-error -shell-escape
PDF_VIEWER := zathura


all: ${BUILD_DIR} ${OUTPUT_FILES}

view: all
	${PDF_VIEWER} ${OUTPUT_FILES}

clean:

	@# delete unneeded directories
	rm -rf ${BUILD_DIR} # delete build directory
	@rm -rf ${SRC_BACKUP}

	@# save only tex files from source directory
	@mkdir ${SRC_BACKUP}
	@mv ${SRC_DIR}/*.tex ${SRC_BACKUP}

	@# delete extra files and replace tex files
	rm -f ${SRC_DIR}/* # delete non-tex files
	@mv ${SRC_BACKUP}/* ${SRC_DIR}

	@# delete extra directory
	@rm -rf ${SRC_BACKUP}

${BUILD_DIR}:
	mkdir ${BUILD_DIR}

${BUILD_DIR}/%.pdf: ${SRC_DIR}/%.tex
	${LATEX} ${LATEX_ARGS} $<
