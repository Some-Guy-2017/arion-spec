.PHONY: all clean view

SRC_DIR := ./src/
SRC_BACKUP := ./.src-backup/
IMG_DIR := ./img/
BUILD_DIR := ./build/

TEX_FILE := $(wildcard ${SRC_DIR}/*.tex)
OUTPUT_FILES := $(TEX_FILE:${SRC_DIR}/%.tex=${BUILD_DIR}/%.pdf)
BACKUP_FILES := $(wildcard ${SRC_BACKUP}/*)
IMG_FILES := $(wildcard ${IMG_DIR}/*)

LATEX := pdflatex
LATEX_ARGS := -output-directory ${BUILD_DIR} -halt-on-error -shell-escape
PDF_VIEWER := zathura


all: ${BUILD_DIR} ${OUTPUT_FILES}

view: all
	${PDF_VIEWER} ${OUTPUT_FILES}

clean:

	rm -rf ${BUILD_DIR}

	@# move files from backup dir to source dir
	@if [ ! -z "${BACKUP_FILES}" ]; then \
		echo mv ${SRC_BACKUP}/* ${SRC_DIR}; \
		mv ${SRC_BACKUP}/* ${SRC_DIR}; \
	fi
	@rm -rf ${SRC_BACKUP}

	@# save only tex files from source directory
	@mkdir ${SRC_BACKUP}
	@mv ${SRC_DIR}/*.tex ${SRC_BACKUP}

	@# delete extra files and replace tex files
	rm -rf ${SRC_DIR}/*
	@mv ${SRC_BACKUP}/* ${SRC_DIR}

	@# delete extra directory
	@rm -rf ${SRC_BACKUP}

${BUILD_DIR}:
	mkdir ${BUILD_DIR}

${BUILD_DIR}/%.pdf: ${SRC_DIR}/%.tex ${IMG_FILES}
	${LATEX} ${LATEX_ARGS} $<
