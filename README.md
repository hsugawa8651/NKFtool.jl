# NKFtool

NKFtool: Julia package for converting kanji code using nkf
====================================

NKFtool is a [Julia](https://julialang.org) package for guessing and converting
kanji (Japanese characters) code. It is the wrapper module
to Network kanji filter, aka [nkf](https://osdn.net/projects/nkf/),
and provides the interface to use nkf from Julia.

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://hsugawa8651.github.io/NKFtool.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://hsugawa8651.github.io/NKFtool.jl/dev)
[![Build Status](https://travis-ci.com/hsugawa8651/NKFtool.jl.svg?branch=master)](https://travis-ci.com/hsugawa8651/NKFtool.jl)
[![Codecov](https://codecov.io/gh/hsugawa8651/NKFtool.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/hsugawa8651/NKFtool.jl)

Installation
------------

NKFtool requires nkf to be installed in your system. Major Unix-like operating systems offer its precompiled version in their package management systems.

NKFtool also requires Julia v1.0 or above.

To install NKFtool using Julia's packaging system, enter Julia's package manager prompt with `]`, and run

    (v1.1) pkg> add NKFtool


Version
------------
The current package is tested with "Network Kanji Filter Version 2.1.5 (2018-12-15)"
