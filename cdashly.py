#!/usr/bin/env python

#  This software is distributed WITHOUT ANY WARRANTY; without even
#  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#  PURPOSE.  See the above copyright notice for more information.

"""CDashly.

Usage:
    cdashly.py clone <src_hostname> <dest_hostname> [--sitename_suffix=<sns>] [--force]
    cdashly.py replace <wildcard_expression> <old_value> <new_value> [--apply]
    cdashly.py (-h | --help)
    cdashly.py --version

Options:
    -h --help                Show this screen.
    --version                Show version.        
    --apply                  Proceed to the replacement.
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
        updated_lines = []
        with open(file, 'r') as lines:
            for line in lines:
                for expr in expressions:
                    if re.match(expr, line):
                        line = re.sub(expr, '\\1%s\\3' % dest_hostname, line)
                        break;
                updated_lines.append(line)
        
        # Write updated lines into destination file
        with open(dest_file, 'w') as f:
            for line in updated_lines:
                f.write(line)
        
        dest_files.append(dest_file)
    return dest_files

def replace(directory, wildcard_expression, old_value, new_value, preview = True):
    files = recursively_list_file_within_directory(directory, wildcard_expression)
    for file in files:
        updated_lines = []
        matched_lines = []
        with open(file, 'r') as lines:
            for linenumber, line in enumerate(lines):
                if line.find(old_value) >= 0:
                    matched_lines.append((linenumber, line))
                updated_lines.append(line.replace(old_value, new_value))
        if preview:
            if len(matched_lines) > 0:
                print("File: %s" % file)
                for (linenumber, line) in matched_lines:
                    print("    %d: %s" % (linenumber, line))
        else:
            with open(file, 'w') as f:
                for line in updated_lines:
                    f.write(line)

if __name__ == '__main__':
      arguments = docopt(__doc__, version='CDashly 0.1')
      directory = '.'
      if arguments['clone']:
          clone(directory, arguments['<src_hostname>'], arguments['<dest_hostname>'], arguments['--sitename_suffix'], arguments['--force'])
      elif arguments['replace']:
          replace(directory, arguments['<wildcard_expression>'], arguments['<old_value>'] , arguments['<new_value>'], not arguments['--apply'])

