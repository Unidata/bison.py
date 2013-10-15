PROJECT=bison.py

all: 

check::
	cd tests; ${MAKE} check	

clean::
	rm -fr dist
	rm -fr export
	cd tests; ${MAKE} clean

dist::
	python setup.py sdist

export::
	${SH} ./export.sh ${PROJECT}

install::
	cp -fr ./export/${PROJECT} ${EXPORT}
