#!/usr/bin/env python

from setuptools import setup

setup(
    name='cdashly',
    py_modules=['cdashly'],
    entry_points={'console_scripts': ['cdashly=cdashly:main']},
    license='Apache 2.0',
    install_requires=['docopt'],
    )

