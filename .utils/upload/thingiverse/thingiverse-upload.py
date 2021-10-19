#!/usr/bin/python
'''
    File name: thingiverse-upload.py
    Description: Uploads files to Thingiverse
    To authorize:
        navigate to: https://www.thingiverse.com/login/oauth/authorize?client_id=94e3e7953b416c725d7a&response_type=token

    Author: Matteo Bonora
    Date created: 12/10/2021
'''
 
import os
import sys
sys.path.append(os.path.join(sys.path[0],'thingiverse'))
import thingiverse
import json
from requests_toolbelt import MultipartEncoder
import requests
from requests import Request, Session

from urllib.parse import unquote, urlparse
from pathlib import Path,PurePosixPath

from common import KEY,SECRET,TOKEN,UPLOAD_FILE, check_error

if len(sys.argv)==1:
    print("Expected file")
    exit(1)

target=Path(sys.argv[1])
if not (os.path.exists(target) and os.path.isfile(target)):
    print(f"File not found. [file={target}]")
    exit(1)

file=os.path.basename(target)
ufile=Path(os.path.dirname(target))/UPLOAD_FILE

# Check whether the upload definition file exists in the given path
if not (os.path.exists(ufile) and  os.path.isfile(ufile)):
    print(f"Upload definition file not found. [file={ufile}]")
    exit(0)

# Open upload definition file
with open(ufile) as f:
    upload=dict(json.load(f).items())

# If thingiverse not defined in file
if "thingiverse" not in upload.keys():
    print(f"No thingiverse entry in path. [path={UPLOAD_FILE}]")
    exit(0)

upload=upload["thingiverse"]
thing_id=upload["thing_id"]

if not file in upload['files']:
    print(f"Nothing to do. [file={target}]")
    exit(0)
else:
    
    # Connect to thingiverse
    t = thingiverse.Thingiverse({'client_id': KEY, 'client_secret': SECRET, 'redirect_uri': ''})
    t.connect(TOKEN)

    # Get thing and check existence
    thing=t.get_thing(thing_id)
    check_error(thing)

    # Get list of already uploaded files
    online_files=t.get_thing_file(thing_id, None)

    # Check file existence
    for f in online_files:
        # Delete online file if it already exists.
        print(f['date'])
        if file in f["name"]:
            t.delete_thing_file(thing_id, f["id"])
            print(f"Deleted already existing file. [file={file}]")

    # Get upload info from Thingiverse
    data = json.dumps({"filename": file})
    upload_info=t.upload_thing_file(thing_id, data)
    print(f"Got upload data from Thingiverse. [file={file}]")

    # Create message for S3
    fields={**upload_info['fields'], **{'file': (file, open(target, 'rb'), upload_info['fields']['Content-Type'])}}
    m = MultipartEncoder(fields)

    # Upload file for AWS S3 storage
    url=upload_info["action"]
    res=requests.post(url, data = m, headers = {'Content-Type': m.content_type}, allow_redirects=False)
    print(f"New version of file uploaded. [file={file}, return={res.status_code}]")

    # Get file id to notify Thingiverse of new file
    file_id=int(PurePosixPath(unquote(urlparse(upload_info["fields"]["success_action_redirect"]).path)).parts[2])
    type(file_id)

    res=t.finalize_file(file_id)
    check_error(res)
    print(f"Thingiverse notified of new file. [file={file}]")
