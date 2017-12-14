# Manifest Management Command Line Interface

This is a command line tool used to generate a manifest file, created as a coding test.

## Installation

`gem install mmcli`

## Usage

`mmcli <manifest-file-path> [-a <glob>] [-d <glob>] [-c][-h][-l]`

### Arguments

`manifest-file-path` is a path to the manifest file, which is a text file containing a list of absolute file paths, each on its own line.

### Options

**-a <glob>** adds file paths to the manifest for any file which matches the glob pattern

**-d <glob>** deletes file paths from the manifest for any file which matches the glob pattern

**-c** cleans up the manifest file by deleting paths for any non-existent files

**-h** displays help

**-l** list the contents of the manifest file

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bgates/mmcli.

