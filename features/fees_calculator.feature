Feature: retrieve fees calculator

  As a visitor

  I want to retrieve and read the fees calculator page

  In order to understand what the fees are for Land Registry services

  @javascript
  Scenario:
    Given a visitor
    When she retrieves the page "/fees-calculator.html"
    Then she should retrieve a web page
    And  it should have the title "Fees Calculator"
    And  it should have content "Fee calculator"
    And  it should have an image matching "lr_logo.*\.png$"
    And  it should have rules from stylesheet matching "normalize.css$"
    And  it should have rules from stylesheet matching "global.css$"
    And  it should have rules from stylesheet matching "fc_style.css$"



