#!/usr/bin/env python
import requests, argparse

class bColors:
    HEADER = '\033[95m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'


parser = argparse.ArgumentParser()

# Filtering parameters
parser.add_argument("-c", "--country", dest="country",
                    help="Generates results for country")
parser.add_argument("-s", "--status", dest="status",
        help="Generates results for repo status: green, red, yellow")

args = parser.parse_args()



def get_mirrors(url):
    request = requests.get(url)

    for row in request.json():
        if args.country == None and args.status == None:
            categorize(row)
        elif args.country == row['country']:
            categorize(row)
        elif args.status != None and args.country == None:
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
    if args.status == None or args.status == "green":
        print(bColors.OKGREEN + "✔ ✔ ✔ " + row['country'] + " " + row['url'] + " " + str(row['last_sync']) + bColors.ENDC)

def redify(row):
    if args.status == None or args.status == "red":
        print(bColors.FAIL + "✘ ✘ ✘ " + row['country'] + " " + row['url'] + " " + str(row['last_sync']) + bColors.ENDC)

def yellowify(row):
    if args.status == None or args.status == "yellow":
        status = ""
        for repo in row['branches']:
            if repo == 1:
                status += "✔ "
            else:
                status += "✘ "
        print(bColors.WARNING + status + row['country'] + " " + row['url'] + " " + str(row['last_sync']) + bColors.ENDC)

if __name__ == '__main__':
    get_mirrors("http://repo.manjaro.org/status.json")
