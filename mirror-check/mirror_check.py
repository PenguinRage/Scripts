#!/usr/bin/env python
import requests, sys

class bColors:
    HEADER = '\033[95m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'


def get_mirrors(url):
    request = requests.get(url)
    for row in request.json():
        if sum(row['branches']) == 3:
            if sys.argv[1] == "green" or sys.argv[1] == "all":
                greenify(row)
        elif sum(row['branches']) == 0:
            if sys.argv[1] == "red" or sys.argv[1] == "all":
                redify(row)
        else:
            if sys.argv[1] == "yellow" or sys.argv[1] == "all":
                yellowify(row)


def greenify(row):
    print(bColors.OKGREEN + "✔ ✔ ✔ " + row['country'] + " " + row['url'] + bColors.ENDC)

def redify(row):
    print(bColors.FAIL + "✘ ✘ ✘ " + row['country'] + " " + row['url'] + bColors.ENDC)

def yellowify(row):
    status = ""
    for repo in row['branches']:
        if repo == 1:
            status += "✔ "
        else:
            status += "✘ "
    print(bColors.WARNING + status + row['country'] + " " + row['url'] + bColors.HEADER + bColors.ENDC)

if __name__ == '__main__':
    get_mirrors("http://repo.manjaro.org/status.json")