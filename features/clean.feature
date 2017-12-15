Feature: Cleaning the manifest file
  In order to keep track of which files exist
  I want to remove paths to nonexistent files from the manifest
  So I know what exists in my project

  Scenario: Clean manifest
    Given a file named "manifest.txt" with:
    """
    /a/keeper
    /not/needed
    /another/keeper
    """
    And an empty file named "/a/keeper"
    And an empty file named "/another/keeper"
    When I successfully run "mmcli -c manifest.txt"
    Then the file "manifest.txt" should contain:
    """
    /a/keeper
    /another/keeper
    """
    And the file "manifest.txt" should not contain:
    """
    /not/needed
    """


