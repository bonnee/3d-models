# 3D Models

Collection of self-designed 3D models made for FDM 3D-printing.

## Usage
The included makefile takes care of building this file. It can also generate STL models from [SolveSpace](https://solvespace.com) and [FreeCAD](https://www.freecadweb.org/) project sources.

### Warning
FCStd models are incompatible with upstream FreeCAD. I created them using realthunder's [LinkStage3 branch](https://github.com/realthunder/FreeCAD/tree/LinkStage3) of FreeCAD.

- `make` to generate all
- `make freecad` to export FreeCAD projects to STL meshes
- `make solvespace` to export SolveSpace projects to STL meshes
- `make upload` to upload selected models to Thingiverse. Needs an `upload.json` file like [this one](precision_screwdriver_v2/upload.json).
- `make clean` to clean all.

## Table of contents
TBD

