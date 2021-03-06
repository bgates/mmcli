Feature: Adding to manifest file
  In order to keep track of files I have created
  I want to add file paths to the manifest
  So I know what exists in my project

  # aruba complains that the use of quotes in the 'successfully run' steps
  # is deprecated, but replacing them with backticks blows up
  Scenario: Add single file to empty manifest
    Given an empty file named "manifest.txt"
    And a file named "/add" with: 
    """
    content
    """
    When I successfully run "mmcli manifest.txt -a /add"
    Then the file "manifest.txt" should contain "/add"

  Scenario: Add file and create manifest
    Given a file named "/path/to/add" with:
    """
    content
    """
    When I successfully run "mmcli manifest.txt -a /path/to/add"
    Then the file "manifest.txt" should contain "/path/to/add"

  Scenario: Add multiple files to manifest
    Given a file named "/path/to/one" with:
    """
    content
    """
    And a file named "/path/to/two" with:
    """
    content
    """
    When I successfully run "mmcli manifest.txt -a /path/to/one /path/to/two"
    Then the file "manifest.txt" should contain:
    """
    /path/to/one
    /path/to/two
    """

    # the wildcard expansion happens in the shell before the Ruby code sees it, so this spec doesn't work
    # see https://stackoverflow.com/questions/14077119/how-to-get-aruba-to-expand-wildcards
    #  Scenario: Add files to empty manifest with glob
    #Given an empty file named "manifest.txt"
    #And a directory named "/add_dir"
    #And an empty file named "/add_dir/one.txt"
    #And an empty file named "/add_dir/two.txt"
    #When I successfully run `"mmcli -a /add_dir/* manifest.txt"`
    #Then the file "manifest.txt" should contain:
    #"""
    #/add_dir/one.txt
    #/add_dir/two.txt
    #"""

  Scenario: Append to existing manifest
    Given a file named "manifest.txt" with:
    """
    /pre/existing/path

    """
    And an empty file named "/path/to/add"
    When I successfully run "mmcli manifest.txt -a /path/to/add"
    Then the file "manifest.txt" should contain:
    """
    /pre/existing/path
    /path/to/add
    """

  Scenario: Prevent duplicates in manifest
    Given a file named "manifest.txt" with:
    """
    /pre/existing/path

    """
    And an empty file named "/path/to/add"
    And an empty file named "/pre/existing/path"
    When I successfully run "mmcli manifest.txt -a /path/to/add /pre/existing/path"
    Then the file "manifest.txt" should contain:
    """
    /pre/existing/path
    /path/to/add
    """
    And the file "manifest.txt" should not contain:
    """
    /path/to/add
    /pre/existing/path
    """

  Scenario: Ignore duplicates in arguments to add
    Given a file named "manifest.txt" with:
    """
    /pre/existing/path

    """
    And an empty file named "/path/to/add"
    And an empty file named "/pre/existing/path"
    When I successfully run "mmcli manifest.txt -a /path/to/add /path/to/add /pre/existing/path"
    Then the file "manifest.txt" should contain:
    """
    /pre/existing/path
    /path/to/add
    """
    And the file "manifest.txt" should not contain:
    """
    /path/to/add
    /path/to/add
    """

  Scenario: Prevent addition of nonexistent files
    Given an empty file named "/existent"
    When I successfully run "mmcli manifest.txt -a /existent /nonexistent"
    Then the file "manifest.txt" should contain "/existent"
    And the file "manifest.txt" should not contain "/nonexistent"
