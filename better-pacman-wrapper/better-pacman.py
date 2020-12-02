#!/usr/bin/env python
import requests, argparse
import os

current_region = ""
fh = open('/etc/pacman.d/mirrorlist')
for line in fh:
    if "Country" in line:
        current_region = line.split()[-1]
fh.close()


class bColors:
    HEADER = '\033[95m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

intro ='''
__________        __    __              __________                                      
\______   \ _____/  |__/  |_  __________\______   \_____    ____   _____ _____    ____  
 |    |  _// __ \   __\   __\/ __ \_  __ \     ___/\__  \ _/ ___\ /     \\__  \  /    \\ 
 |    |   \  ___/|  |  |  | \  ___/|  | \/    |     / __ \\  \___|  Y Y  \/ __ \|   |  \\
 |______  /\___  >__|  |__|  \___  >__|  |____|    (____  /\___  >__|_|  (____  /___|  /
        \/     \/                \/                     \/     \/      \/     \/     \/ 
        Current Region: ''' + current_region    
print(intro)
parser = argparse.ArgumentParser()

# Filtering parameters
parser.add_argument("-c", "--country", dest="country",
                    help="Generates results for country")
parser.add_argument("-s", "--status", dest="status",
        help="Generates results for repo status: green, red, yellow")
parser.add_argument("-i", "--install", dest='install', help="Installs programs")
parser.add_argument("-r", "--remove", dest='remove', help="Removes programs")
parser.add_argument("-u", "--update", action='store_true', help="Updates programs")
parser.add_argument("-m", "--mirrors", action='store_true', help="Updates programs")


args = parser.parse_args()


def run_operations():
    if args.country is not None and args.country != current_region:
        print("\n----------------------------------------------------------------------")
        if input(bColors.WARNING +"Would you like to change region? y/n " + bColors.ENDC) == "y":
            command = "sudo pacman-mirrors -c" + args.country
            os.system(command)
            print("\n----------------------------------------------------------------------")
    if args.update:
        if input(bColors.WARNING +"Would you like to update System? y/n " + bColors.ENDC) == "y":
            command = "sudo pacman -Syu"
            os.system(command)
            print("\n----------------------------------------------------------------------")
    if args.remove is not None:
        print("\n----------------------------------------------------------------------")
        command = "sudo pacman -R " + args.remove
        os.system(command)
        print("\n----------------------------------------------------------------------")
    if args.install is not None:
        print("\n----------------------------------------------------------------------")
        command = "sudo pacman -S " + args.install
        os.system(command)
        print("\n----------------------------------------------------------------------")


def get_mirrors(url):
    try:
        request = requests.get(url)
    except requests.exceptions.RequestException as e:
        raise SystemExit(e)

    for row in request.json():
        if current_region == row['country']:
            categorize(row)
    
    if args.country is not None and args.country == current_region:
        return
    print("\n----------------------------------------------------------------------")
    if args.country is not None:
        print(current_region + " -> " + args.country)
    for row in request.json():
        if args.mirrors:
            categorize(row)
        elif args.status is not None:
            categorize(row)
        elif args.country == row['country']:
            categorize(row)


def categorize(row):
    if sum(row['branches']) == 3: 
        greenify(row)
        return
    elif sum(row['branches']) == 0:
        redify(row)
        return
    else:
        yellowify(row)
        return


def greenify(row):
    if args.status is None or args.status == "green":
        print(bColors.OKGREEN + "✔ ✔ ✔ " + row['country'] + " " + row['url'] + " " + str(row['last_sync']) + bColors.ENDC)


def redify(row):
    if args.status is None or args.status == "red":
        print(bColors.FAIL + "✘ ✘ ✘ " + row['country'] + " " + row['url'] + " " + str(row['last_sync']) + bColors.ENDC)


def yellowify(row):
    if args.status is None or args.status == "yellow":
        status = ""
        for repo in row['branches']:
            if repo == 1:
                status += "✔ "
            else:
                status += "✘ "
        print(bColors.WARNING + status + row['country'] + " " + row['url'] + " " + str(row['last_sync']) + bColors.ENDC)


if __name__ == '__main__':
    get_mirrors("http://repo.manjaro.org/status.json")
    run_operations()
