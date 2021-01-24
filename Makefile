MDS := $(shell find -mindepth 2 -name "*.md")

TARGET=README.md

.PHONY: all
all: header $(TARGET)

define NEWLINE

endef

define HEADER
# 3D Models

Collection of self-designed 3D models
## Table of contents
endef
export HEADER

define toc
	$(shell echo "$(NEWLINE)${\n}### [$(lastword $(subst /, , $(dir $(1))))]($(abspath $(dir $(1))))" >> $(TARGET))
	$(shell cat $(1) >> $(TARGET))
endef

$(TARGET): header
	$(foreach file, $(MDS), $(call toc, $(file)))

header:
	echo "$$HEADER" > $(TARGET)