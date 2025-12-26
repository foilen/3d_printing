#!/bin/bash

set -e

exiftool -gps:all= -overwrite_original -ext jpg -r .
