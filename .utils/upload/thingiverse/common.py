import os

def check_error(res):
    if 'error' in res.keys():
        print(res['error'])
        exit(1)

