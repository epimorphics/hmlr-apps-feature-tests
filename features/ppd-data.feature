
Feature: retrieve PPD data downloads

  As a visitor

  I want to retrieve and read the PPD datasets page

  In order to be able to download PPD monthly datasets

  Scenario:
    Given a visitor
    When she retrieves the page "/ppd-data.html"
    Then she should retrieve a web page
    And  it should have the title "Download Price Paid Data"
    And  it should have content "Price paid data download options"



