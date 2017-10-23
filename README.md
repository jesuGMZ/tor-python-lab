Project with sample scripts to play around with Tor through Python.

## Build Docker image ##

`docker build -t tor_python_lab .`

## Running samples ##

### stem-simple.py ###
It uses [Stem](https://stem.torproject.org/) to control Tor from Python.

`docker run --rm -it -v ${PWD}:/app tor_python_lab python stem-simple.py`
