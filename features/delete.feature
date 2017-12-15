Feature: Deleting from manifest file
  In order to keep track of files I have created
  I want to remove file paths from the manifest
  So I know what exists in my project

  Scenario: Delete single file from manifest
    Given a file named "manifest.txt" with:
    """
    /a/keeper
    /not/needed
    /another/keeper
    """
    When I successfully run "mmcli manifest.txt -d /not/needed"
    Then the file "manifest.txt" should contain:
    """
    /a/keeper
    /another/keeper
    """
    And the file "manifest.txt" should not contain:
    """
    /not/needed
    """

  Scenario: Delete multiple files from manifest
    Given a file named "manifest.txt" with:
    """
    /a/keeper
    /toss/this
    /useful
    /toss/please
    /nice
    """
    When I successfully run "mmcli manifest.txt -d /toss/this /toss/please"
    Then the file "manifest.txt" should contain:
    """
    /a/keeper
    /useful
    /nice
    """

  Scenario: Delete multiple files from manifest with glob
    Given a file named "manifest.txt" with:
    """
    /a/keeper
    /toss/this
    /useful
    /toss/please
    /nice
    """
    When I successfully run "mmcli manifest.txt -d /toss/*"
    Then the file "manifest.txt" should contain:
    """
    /a/keeper
    /useful
    /nice
    """
