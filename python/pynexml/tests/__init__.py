#! /usr/bin/env python

############################################################################
##  __init__.py
##
##  Part of the PyNexml phylogenetic data parsing library.
##
##  Copyright 2007 Jeet Sukumaran and Mark T. Holder.
##
##  This program is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License along
##  with this program. If not, see <http://www.gnu.org/licenses/>.
##
############################################################################
"""
pynexml testing suite
"""

import os

def test_source_path(filename):
    return os.path.join('sources', filename)
    
def test_target_path(filename):
    return os.path.join('output', filename)

