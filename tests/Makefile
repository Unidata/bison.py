D=01 02 03 04a 04b 04c 05 06 07 08 09 10 11 12 13 14 15 16

all:

check:
	for d in ${D} ; do (cd $$d; sh ./run); done

clean::
	for d in ${D} ; do (cd $$d; sh ./run clean); done
