#!/usr/bin/python
# delete_thumbnails.py 
#   This Nautilus script attempts to locate and delete thumbnails of selected 
#   files
#
# Copyright 2007 Barak Korren
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This script is currently not very smart, it simply does a recursive search
# in ~/.thumbnails deleting all matching thumbnails it finds, a smarter script
# would not recuse into directories in ~/.thumbnails/large and 
# ~/.thumbnails/normal since such directories do not contain thumbnails 
# according to ths standard.
#
# The file serch could be optimized as well, curently it does O(n^2) kartezian
# duplication scan (e.g. compares each thumbnail name to each file name in each
# directory), which could run a little slow on older machines or ones with 
# gigantic amounts of thumbnails.
#

import os
import md5

try:
        thumbs = [md5.new(url).hexdigest() + '.png' for url in
                        os.environ['NAUTILUS_SCRIPT_SELECTED_URIS'].splitlines()]
        tokill = list()
        for root, dirs, files in os.walk(os.path.expanduser('~/.thumbnails')):
                tokill.extend([os.path.join(root,f)
                        for t in thumbs for f in files if f == t]);
        #print tokill
        for f in tokill:
                os.remove(f);
except KeyError, e:
        if e.message == 'NAUTILUS_SCRIPT_SELECTED_URIS':
                print 'NAUTILUS_SCRIPT_SELECTED_URIS environment variable not \
available! are you running this from Nautilus?'
                exit(1)
        else:
                raise

