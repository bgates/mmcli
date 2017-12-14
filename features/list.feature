Feature: Displaying manifest file
  In order to see what's on the manifest
  I want to display the file contents
  So I know what needs to be added/removed without opening the file

  Scenario: Manifest file exists
    Given a file named "manifest.txt" with:
    """
    /path/to/file1
    /path/to/file2
    """
    When I successfully run "mmcli -l manifest.txt"
    Then the output should contain "/path/to/file1"



