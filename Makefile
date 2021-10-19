#FREECADOUT := $(shell mktemp)
FREECADOUT="/tmp/freecadout"

MDS := $(sort $(shell find -mindepth 2 -type f -name "*.md"))

SLVS := $(shell find -mindepth 2 -type f -name "*.slvs")
SLVS_STL := $(SLVS:.slvs=.stl)

FCS := $(shell find -mindepth 2 -type f -name "*.FCStd")
FCS_STL_ESCAPED = $(foreach file, $(FCS), $(shell FreeCADCmd -P. "$(file)" ./.utils/freecad_names.py $(FREECADOUT) > /dev/null; cat $(FREECADOUT)))
# Escaped STL list for shell commands
FCS_STL = $(foreach file, $(FCS_STL_ESCAPED), $(shell ./.utils/unescape_name.py $(file)))

UPLOAD_DEF = $(shell find -mindepth 2 -type f -name ".upload.json")
UPLOAD_REF = $(foreach file, $(UPLOAD_DEF), $(shell ./.utils/upload/thingiverse/thingiverse-timestamp.py "$(file)"))

README = README.md
#README := $(addsuffix README.md,$(dir $(FCS))) $(addsuffix README.md,$(dir $(SLVS)))

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

#define toc
#	@echo appending $(1)
#	$(shell echo "$(NEWLINE)${\n}### [$(lastword $(subst /, , $(dir $(1))))]($(dir $(1)))" >> $(README))
#	$(shell awk 1 $(1) >> $(README))
#endef

.PHONY: all
all: readme solvespace freecad

.PHONY: readme
readme: $(README)

.PHONY: freecad
freecad: $(FCS_STL)

.PHONY: solvespace
solvespace: $(SLVS_STL)

.PHONY: upload
upload: freecad solvespace $(UPLOAD_REF)

%.thingiverse:
	./.utils/upload/thingiverse/thingiverse-upload.py $^

.PHONY: clean
clean:
	-rm $(README)
	-rm $(SLVS_STL)
	-rm $(FCS_STL_ESCAPED)

$(README): header $(MDS)
	$(foreach file, $(MDS), $(call toc, $(file)))
	@echo done

.PHONY: header
header:
	@echo "$$HEADER" > $(README)

.SECONDEXPANSION:
%.stl: $$(@D)/*.FCStd
	FreeCADCmd -P. "$^" ./.utils/freecad_export.py "$@"

%.stl: %.slvs
	solvespace-cli export-mesh --chord-tol 0.05 "$^" -o "$@"
