# version.sh #

## Description ##

A bash script for generator version.h with git.

Replace the keywords from file *./version.h.in* with version information get 
from command `git describe` then output to version.h

## Reauire ##
- Linux / Mac OS / Windows(cygwin)
- git and git project

## Usage ##
```
./version.sh -[p|c]
```

## OPTIONS ##
| opt | description |
|-----|------------ |
|-c   | Convert version.h.in to version.h. If version.h exist, cover it.|
|-p   | print all version information.|
