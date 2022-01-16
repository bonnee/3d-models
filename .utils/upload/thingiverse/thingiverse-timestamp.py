#!/usr/bin/python
# Creates .thingiverse files containing upload timestamp for every file listed in upload.json

import os
import sys

sys.path.append(os.path.join(sys.path[0],'thingiverse'))
import thingiverse
import json
from datetime import timezone,datetime
from pathlib import Path,PurePosixPath

from common import KEY,SECRET,TOKEN,check_error

if len(sys.argv)==1:
    print("Expected file")
    exit(1)

ufile=Path(sys.argv[1])
# Check whether the given upload definition file exists
if not (os.path.exists(ufile) and  os.path.isfile(ufile)):
    print(f"Upload definition file not found. [file={ufile}]")
    exit(1)

base_path=os.path.dirname(ufile)

# Open upload definition file
with open(ufile) as f:
    upload=dict(json.load(f).items())

# If thingiverse not defined in file
if "thingiverse" not in upload.keys():
    print(f"No thingiverse entry in path. [path={ufile}]")
    exit(0)

upload=upload["thingiverse"]
thing_id=upload["thing_id"]
files=upload["files"]

# Connect to thingiverse
t = thingiverse.Thingiverse({'client_id': KEY, 'client_secret': SECRET, 'redirect_uri': ''})
t.connect(TOKEN)

# Get thing and check existence
thing=t.get_thing(thing_id)
check_error(thing)

# Get list of already uploaded files
online_files=t.get_thing_file(thing_id, None)

for file in files:
    for ofile in online_files:
        if ofile['name'] == file:
            print(ofile.keys())
            # If file matches, return upload timestamp
            dt=datetime.strptime(ofile['date'], "%Y-%m-%d %H:%M:%S")
            dt=dt.replace(tzinfo=timezone.utc).timestamp()

            fname=Path(base_path)/Path(''+file +'.thingiverse')
            f=open(fname,'w')
            f.write(str(ofile['id'])+'\n')
            f.close()
            os.utime(fname,(dt,dt))
            print(fname)

