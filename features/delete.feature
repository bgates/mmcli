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
    When I successfully run "mmcli -d /not/needed manifest.txt"
    Then the file "manifest.txt" should contain:
    """
    /a/keeper
    /another/keeper
    """
    And the file "manifest.txt" should not contain:
    """
    /not/needed
    """


