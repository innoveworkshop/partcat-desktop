# Makefile
# Helps manage everything in a automated manner.
#
# Author: Nathan Campos <nathan@innoveworkshop.com>

# Programs.
RM = rm -f
MKDIR = mkdir -p

all:
	./bin/partcat

critic:
	perlcritic -4 bin/ lib/
