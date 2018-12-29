#!/bin/python3
# -*- coding: utf-8 -*-

from argparse import ArgumentParser
from os import path, system
from shutil import copy2
from json import dump, load

user_home_dir = path.expanduser("~")
user_conf_dir = user_home_dir + '/.config'
this_dir = path.dirname(path.realpath(__file__))

with open('configs.json', 'r') as conf_file:
    configs = load(conf_file)
    for key in configs.keys():
        configs[key]['path'] = configs[key]['path'].replace('$HOME', user_home_dir)
        configs[key]['path'] = configs[key]['path'].replace('$CONF', user_conf_dir)
    configs['_'] = ''

do_options = ['copy', 'deploy', 'copy_all', 'deploy_all', 'add_config', 'remove_config', 'push']

def copy(file_name, file_folder):
    if path.exists(file_folder+'/'+file_name):
        print("copying {} from {} to {}".format(file_name, file_folder, this_dir))
        copy2(path.join(file_folder, file_name), path.join(this_dir, file_name))
    else:
        print('path to this file doesn\'t exist')
    return

def deploy(file_name, file_folder):
    if path.exists(file_folder+'/'+file_name):
        print("copying {} from {} to {}".format(file_name, this_dir, file_folder))
        copy2(path.join(this_dir, file_name), path.join(file_folder, file_name))
    else:
        print('path to this file doesn\'t exist')
    return

parser = ArgumentParser(description='copy and deploy your configs\n(mine by default)')
parser.add_argument('do', choices=do_options, help='choose what you want to do')
parser.add_argument('files', choices=configs.keys(), nargs='*', type=str, help='specify programs', default='_')
args = parser.parse_args()

if args.do == 'copy_all':
    del configs['_']
    for arg_file in configs.keys(): copy(configs[arg_file]['real_name'], configs[arg_file]['path'])
    configs['_'] = ''
elif args.do == 'deploy.all':
    del configs['_']
    for arg_file in configs.keys(): deploy(configs[arg_file]['real_name'], configs[arg_file]['path'])
    configs['_'] = ''
elif args.do == 'remove_config':
    name = input('specify the name of the program: ')
    while name == '':
        name = input('specify the name of the program: ')
    with open('configs.json', 'r') as conf_file:
        configs = load(conf_file)
        del configs[name] 
    with open('configs.json', 'w') as conf_file:
        dump(configs, conf_file)
elif args.do == 'add_config':
    name = input('specify the name of the program: ')
    while name == '':
        name = input('specify the name of the program: ')
    real_name = input('specify the name of the config file: ')
    while real_name == '':
        real_name = input('specify the name of the config file: ')
    path = input('specify the path to the config file(you can use $HOME and $CONF for relative path): ')
    while path == '':
        path = input('specify the path to the config file(you can use $HOME and $CONF for relative path): ')
    if name in configs.keys():
        print('config for this program already exists, use remove_config to remove it')
    with open('configs.json', 'r') as conf_file:
        configs = load(conf_file)
        configs[name] = {'real_name': real_name, 'path': path} 
    with open('configs.json', 'w') as conf_file:
        dump(configs, conf_file)
elif args.do == 'push':
    ans = input('this will commit all files and try to push, proceed? (y/n)')
    while ans not in ['Y', 'y', 'n', 'N']:
        ans = input('this will commit all files and try to push, proceed? (y/n)')
    if ans in ['Y', 'y']:
        try:
            system('git add --all')
            system('git commit -m "added configs"')
            system('git push')
        except:
            print('Error acured, try pushing manually')
elif args.do == 'copy':
    for arg_file in args.files: copy(configs[arg_file]['real_name'], configs[arg_file]['path'])
elif args.do == 'deploy':
    for arg_file in args.files: deploy(configs[arg_file]['real_name'], configs[arg_file]['path'])

