MDS := $(sort $(shell find -mindepth 2 -name "*.md"))
SLVS := $(shell find -mindepth 2 -name "*.slvs")

README=README.md

define NEWLINE

endef

define HEADER
# 3D Models

Collection of self-designed 3D models
## Table of contents
endef
export HEADER

define toc
	@echo appending $(1)
	$(shell echo "$(NEWLINE)${\n}### [$(lastword $(subst /, , $(dir $(1))))]($(dir $(1)))" >> $(README))
	$(shell awk 1 $(1) >> $(README))
endef

.PHONY: all
all: $(README) $(SLVS:.slvs=.stl)

.PHONY: readme
readme: $(README)

.PHONY: clean
clean:
	rm $(README) $(SLVS:.slvs=.stl)

$(README): header
	$(foreach file, $(MDS), $(call toc, $(file)))
	@echo done

header:
	@echo "$$HEADER" > $(README)

%.stl: %.slvs
	solvespace-cli export-mesh --chord-tol 0.01 $^ -o $@