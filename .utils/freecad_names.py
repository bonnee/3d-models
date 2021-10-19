#!/usr/bin/python
#
# Return STL names
#
# This script returns the names of all active bodies in the following format: <filename>-<bodyname>.stl
#

# Destination for redirected output

import os.path
import sys
import re

import FreeCAD
import Mesh
FreeCAD.Console.SetStatus("Console", "Log", False)
FreeCAD.Console.SetStatus("Console", "Msg", False)
FreeCAD.Console.SetStatus("Console", "Wrn", False)

freecadout="/tmp/freecadout" #sys.argv[len(sys.argv)-1]

f=open(freecadout, 'w')

doc = FreeCAD.activeDocument()
base_filename = os.path.splitext(doc.FileName)[0]

for obj in doc.RootObjects:
    partname = obj.Label

    filename = base_filename + '-' + partname + '.stl'

    # Write to stderr since FreeCAD writes shit on stdout
    #sys.stderr.write(filename+' ')
    #f.write((filename+'\n').replace(" ", "\ ").replace("(","\(").replace(")", "\)"))
    #f.write(shlex.quote(filename+'\n'))
    filename=filename.replace(' ','_')
    if True:
        f.write(re.sub("(!|\$|#|&|\"|\'|\(|\)|\||<|>|`|\\\|;| )", r"\\\1",filename)+'\n')
    else:
        f.write(filename+'\n')

    #sys.stdout.write('"'+filename+'" ')
f.close()
#sys.stderr.write('\n')

