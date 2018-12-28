#!/bin/python3
# -*- coding: utf-8 -*-

import argparse
import os
from shutil import copy2

user_home_dir = os.path.expanduser("~")
this_dir = os.path.dirname(os.path.realpath(__file__))

options = {
        'zshrc':{'real_name':'.zshrc', 'dir':user_home_dir},
        'tmux':{'real_name':'.tmux.conf', 'dir':user_home_dir}
        #'':{'real_name':'', 'path':''},
}

def copy(file_name, file_folder):
    print("copying {} from {} to {}".format(file_name, file_folder, this_dir))
    copy2(file_folder+'/'+file_name, this_dir)
    return

def deploy(file_name, file_folder):
    print("copying {} from {} to {}".format(file_name, config_dir, this_folder))
    copy2(this_dir, file_folder+'/'+file_name) 
    return

parser = argparse.ArgumentParser(description='copy and deploy your configs\n(mine by default)')
parser.add_argument('do', choices=['copy', 'deploy', 'copy_all', 'deploy_all'], help='')
parser.add_argument('files', choices=options.keys(), type=str, nargs=argparse.REMAINDER, help='')
args = parser.parse_args()

if args.do == 'copy_all' or args.do == 'deploy_all':
    args.files = options.keys()
elif args.do == 'copy':
    for arg_file in args.files: copy(options[arg_file]['real_name'], options[arg_file]['dir'])
elif args.do == 'deploy':
    for arg_file in args.files: deploy(options[arg_file]['real_name'], options[arg_file]['dir'])

