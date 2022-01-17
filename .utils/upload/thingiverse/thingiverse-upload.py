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

from common import check_error

def __init__():
    if len(sys.argv)==1:
        print("No file arguments provided.")
        exit(1)
    
    ufile=Path(sys.argv[1])

    if 'THINGIVERSE_KEY' not in os.environ:
        print(f"THINGIVERSE_KEY environment variable not set.")
        exit(1)
    if 'THINGIVERSE_SECRET' not in os.environ:
        print(f"THINGIVERSE_SECRET environment variable not set.")
        exit(1)
    if 'THINGIVERSE_TOKEN' not in os.environ:
        print(f"THINGIVERSE_TOKEN environment variable not set.")
        exit(1)

    KEY=os.environ['THINGIVERSE_KEY']
    SECRET=os.environ['THINGIVERSE_SECRET']
    TOKEN=os.environ['THINGIVERSE_TOKEN']

    # Check whether the upload definition file exists in the given path
    if not (os.path.exists(ufile) and  os.path.isfile(ufile)):
        print(f"Upload definition file not found. [file={ufile}]")
        exit(2)

    base_path=Path(os.path.dirname(ufile))
    
    # Open upload definition file
    with open(ufile) as f:
        upload=dict(json.load(f).items())
    
    # If thingiverse not defined in file
    if "thingiverse" not in upload.keys():
        print(f"No thingiverse entry in path. [path={ufile}]")
        exit(3)
    
    upload=upload['thingiverse']
    thing_id=upload['thing_id']

    # Connect to thingiverse
    print(f"Connecting to thingiverse. [file={ufile}]")
    t = thingiverse.Thingiverse({'client_id': KEY, 'client_secret': SECRET, 'redirect_uri': ''})
    t.connect(TOKEN)

    for f in upload['files']:
        file=base_path/Path(f)
        if not (os.path.exists(file) and  os.path.isfile(file)):
            print(f"Upload definition file not found. [file={file}]")
            exit(2)
        upload_file(t, thing_id, file)

def upload_file(tverse, thing_id, filename):
        basename=os.path.basename(filename)

        # Get thing and check existence
        thing=tverse.get_thing(thing_id)
        check_error(thing)
    
        # Get list of already uploaded files
        online_files=tverse.get_thing_file(thing_id, None)

    
        # Delete online file if it already exists.
        for ofile in online_files:
            if ofile['name'] == basename:
                if ofile['size'] == os.path.getsize(filename):
                    print(f"A file with the same size already exists. [file={basename}]")
                    return
                tverse.delete_thing_file(thing_id, ofile['id'])
                print(f"Deleted already existing file. [file={basename}]")
    
        # Get upload info from Thingiverse
        data = json.dumps({"filename": basename})
        upload_info=tverse.upload_thing_file(thing_id, data)
        print(f"Got upload data from Thingiverse. [file={basename}]")
    
        # Create message for S3
        fields={**upload_info['fields'], **{'file': (basename, open(filename, 'rb'), upload_info['fields']['Content-Type'])}}
        m = MultipartEncoder(fields)
    
        # Upload file for AWS S3 storage
        url=upload_info["action"]
        res=requests.post(url, data = m, headers = {'Content-Type': m.content_type}, allow_redirects=False)
        print(f"New file uploaded. [file={basename}, return={res.status_code}]")
    
        # Get file id to notify Thingiverse of new file
        file_id=int(PurePosixPath(unquote(urlparse(upload_info["fields"]["success_action_redirect"]).path)).parts[2])
        type(file_id)
    
        res=tverse.finalize_file(file_id)
        check_error(res)
        print(f"Thingiverse notified of new file. [file={basename}]")

__init__()
