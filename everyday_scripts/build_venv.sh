#!/bin/bash -e


if [ ! -d "venv" ]; then
	virtualenv -q venv --no-site-packages
	echo "Virtual Environment Created."
fi

if [ ! -f "venv/updated" -o requirements.pip -nt venv/updated ]; then
	pip install -r requirements.pip
	touch venv/updated
	echo "Requirements installed."
fi
