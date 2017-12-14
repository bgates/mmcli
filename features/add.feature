Feature: Adding to manifest file
  In order to keep track of files I have created
  I want to add file paths to the manifest
  So I know what exists in my project

  Scenario: Add single file to empty manifest
    Given an empty file named "manifest.txt"
    When I successfully run "mmcli -a /path/to/add manifest.txt"
    Then the file "manifest.txt" should contain "/path/to/add"




