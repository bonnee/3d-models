MDS := $(sort $(shell find -mindepth 2 -type f -name "*.md"))

SLVS := $(shell find -mindepth 2 -type f -name "*.slvs")
SLVS_STL := $(SLVS:.slvs=.stl)

FCS := $(shell find -mindepth 2 -type f -name "*.FCStd")
FCS_STL := $(FCS:.FCStd=.stl)

README=README.md

define NEWLINE

endef

define HEADER
# 3D Models

Collection of self-designed 3D models made for FDM 3D-printing.

## Usage
The included makefile takes care of building this file. It can also generate STL models from [SolveSpace](https://solvespace.com) and [FreeCAD](https://www.freecadweb.org/) project sources.

- `make` to generate all
- `make readme` to generate this file
- `make freecad` to export FreeCAD projects to STL meshes
- `make solvespace` to export SolveSpace projects to STL meshes
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

.PHONY: header
header:
	@echo "$$HEADER" > $(README)

%.FCStd: %.stl

%.stl: %.FCStd
	@FreeCADCmd -P. $^ freecad_export.py > /dev/null

%.stl: %.slvs
	@solvespace-cli export-mesh --chord-tol 0.01 $^ -o $@
