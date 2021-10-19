#!/usr/bin/python
import sys
import re

print(sys.argv[1].replace('\\', ''))
#print(re.sub("(!|\$|#|&|\"|\'|\(|\)|\||<|>|`|\\\|;| )", r"\\\1", sys.argv[1])+'\n')
