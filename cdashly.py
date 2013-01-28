#!/usr/bin/env python

#  This software is distributed WITHOUT ANY WARRANTY; without even
#  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#  PURPOSE.  See the above copyright notice for more information.

"""CDashly.

Usage:
    cdashly.py clone <src_hostname> <dest_hostname> [--sitename_suffix=<sns>] [--force]
    cdashly.py (-h | --help)
    cdashly.py --version

Options:
    -h --help                Show this screen.
    --version                Show version.
    --force                  Overwrite file if it exists.
    --sitename_suffix=<sns>  Script suffix [default: -64bits].

"""
from docopt import docopt

def recursively_list_file_within_directory(directory, pattern):
    """The returned list of file including the relative path to the provided directory."""
    import fnmatch
    import os

    matches = []
    for root, dirnames, filenames in os.walk(directory):
        for filename in fnmatch.filter(filenames, pattern):
            matches.append(os.path.join(root, filename))
    return matches

def clone(directory, src_hostname, dest_hostname, sitename_suffix, force = False):
    import re
    import os
    import shutil
    
    if sitename_suffix == "":
        raise Exception("'sitename_suffix' should NOT be empty")
    
    expressions = [
        '^(set\(HOSTNAME\s+\")(%s)(\"\))$' % src_hostname,
        '^(HOSTNAME=)(%s)()$' % src_hostname
    ]
    
    src_files = recursively_list_file_within_directory(directory, src_hostname + sitename_suffix + '*')
    src_files.extend(recursively_list_file_within_directory(directory, src_hostname + '_*'))
    dest_files = []
    
    for file in src_files:
        # Generate destination filename
        [dirname, filename] = os.path.split(file)
        dest_filename = re.sub('^%s' % src_hostname, dest_hostname, filename, count=1)
        dest_file = os.path.join(directory, dest_filename)
        
        if os.path.exists(dest_file):
            if not force:
              print("File already exists - Skipping %s" % dest_file)
              continue
            else:
              print("Overwriting file: %s" % dest_file)
      
        # Read file into string, proceed to replacement
        lines = open(file, "r")
        updated_lines = []
        for line in lines:
            matched_expr = False
            for expr in expressions:
                if re.match(expr, line):
                    updated_line = re.sub(expr, '\\1%s\\3' % dest_hostname, line)
                    updated_lines.append(updated_line)
                    matched_expr = True
            if not matched_expr:
                updated_lines.append(line)
        
        # Write updates lines into destination file
        with open(dest_file, 'w') as f:
            for line in updated_lines:
                f.write(line)
        
        dest_files.append(dest_file)


if __name__ == '__main__':
      arguments = docopt(__doc__, version='CDashly 0.1')
      directory = '.'
      if arguments['clone']:
          clone(directory, arguments['<src_hostname>'], arguments['<dest_hostname>'], arguments['--sitename_suffix'], arguments['--force'])

