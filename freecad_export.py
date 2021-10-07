#
# Export All STL
#
# This script exports the active body to an STL mesh file with name: <filename>_<bodyname>.stl
#

import FreeCAD
import Mesh
import os.path
import sys

doc = FreeCAD.activeDocument()
base_filename = os.path.splitext(doc.FileName)[0]

for obj in doc.RootObjects:
    partname = obj.Label
    
    filename = base_filename + "-" + partname + ".stl"
    
    print(f"exporting {filename}", end="...", file=sys.stderr)
    Mesh.export([obj], filename)
    print("done", file=sys.stderr)

