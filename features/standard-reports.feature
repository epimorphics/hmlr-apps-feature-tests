@ci-exclude
Feature: standard-reports

	As a visitor

	I want to retrieve a standard report

    @javascript
    Scenario:
        Given a visitor
        When she retrieves the page "/app/standard-reports"
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"b
        When she clicks on the "create a standard report" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"b
        When she chooses the "report_avgPrice" radio button
        And  she clicks on the "Next" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"b
        When she chooses the "areaType_pcSector" radio button
        And  she clicks on the "Next" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"b
        When she enters "BS20 6" in the "area" field
        And  she clicks on the "Next" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"
        When she clicks on the "Next" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"b
        When she clicks on the "More dates" text
        And  she clicks on a random checkbox
        And  she clicks on the "Next" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"
        Then she selects a random radio button
        And  she clicks on the "Next" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"
        Then she clicks on the "Generate report" button
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"
        And  she waits upto 60 seconds for the link "open-data (csv) format" to appear
        
        
        
        
        