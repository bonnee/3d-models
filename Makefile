MDS := $(sort $(shell find -mindepth 2 -name "*.md"))

SLVS := $(shell find -mindepth 2 -name "*.slvs")
SLVS_STL := $(SLVS:.slvs=.stl)

FCS := $(shell find -mindepth 2 -name "*.FCStd")
FCS_STL := $(FCS:.FCStd=.stl)

README=README.md

define NEWLINE

endef

define HEADER
# 3D Models

Collection of self-designed 3D models made for FDM 3D-printing.

## Usage
The included makefile takes care of building this README.md. It also generates STL models from [SolveSpace](https://solvespace.com) sources.

- `make` to generate all
- `make readme` to generate this file
- `make stl` to only generate STLs
- `make clean` to clean all.

## Table of contents
endef
export HEADER

define toc
	@echo appending $(1)
	$(shell echo "$(NEWLINE)${\n}### [$(lastword $(subst /, , $(dir $(1))))]($(dir $(1)))" >> $(README))
	$(shell awk 1 $(1) >> $(README))
endef

.PHONY: all
all: readme solvespace freecad

.PHONY: readme
readme: $(README)

.PHONY: freecad
freecad: $(FCS_STL)

.PHONY: solvespace
solvespace: $(SLVS_STL)

.PHONY: clean
clean:
	-rm $(README)
	-rm $(SLVS_STL)
	-rm ${patsubst %.stl, %_\(*\).stl, $(FCS_STL)}

$(README): header $(MDS)
	$(foreach file, $(MDS), $(call toc, $(file)))
	@echo done

header:
	@echo "$$HEADER" > $(README)

%.FCStd: %.stl

%.stl: %.FCStd
	@FreeCADCmd -P. $^ freecad_export.py > /dev/null

%.stl: %.slvs
	@solvespace-cli export-mesh --chord-tol 0.01 $^ -o $@