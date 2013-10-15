bison.py
========

'''WARNING''': this document assumes the reader has
significant experience with Bison and Python.  Bison
version 3.0 or later is required.

The goal of this project is allow the use of ''Bison'' to
generate parsers for Python.  The Gnu Bison system
(http://www.gnu.org/software/bison/) is an extremely
powerful compiler generator system.  In its recent
incarnations, it has been extended from its original C
orientations to support the generation of additional parsers
in C++ and Java.  This project extends that support to
include Python.

Ideally, the Python support would be included in the
standard Bison distribution. That would entail, however,
that the Bison development team have Python experience and
the resources to support Python. Neither of these is true,
so this project makes Python support available independent
of the Bison project.

A final note: why do this project? There are several reasons.
# Bison is the most advanced parser generator around. Additionally,
  it is in on-going development and has a dedicated support team.
# Provide principled support for SAX parsing in python. See
  https://github.com/Unidata/yax.git for a discussion of the
  related''yax'' project.

