Feature: retrieve home page

	As a visitor

	I want to retrieve additional price paid data information

    @javascript
    Scenario:
        Given a visitor
        When she retrieves the page "/app/ppd"
        And she enters "AL7 1AJ" in the "postcode" field
        And  she clicks on the "detached" checkbox
        And  she clicks on the "semi-detached" checkbox
        And  she clicks on the "terraced" checkbox
        And  she clicks on the "flat/maisonette" checkbox
        And  she chooses the "all" radio button
        And  she clicks on the "show results" button
        Then she should retrieve a web page
        And  it should have content "8 Brownfields Court, Welwyn Garden City, AL7 1AJ"      
 
    @javascript
    Scenario:
        Given a visitor
        When she retrieves the page "/app/ppd"
        And she enters "AL7 1BX" in the "postcode" field
        And  she clicks on the "other" checkbox
        And  she chooses the "all" radio button
        And  she clicks on the "show results" button
        Then she should retrieve a web page
        And  it should have content "1 The Swallows, Welwyn Garden City, AL7 1BX"      
 