Feature: ppd

	As a visitor

	I want to retrieve information about the price paid for houses

    @javascript
    Scenario:
        Given a visitor
        When she retrieves the page "/app/ppd"
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching ".*application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"b

    @javascript
    Scenario:
        Given a visitor
        When she retrieves the page "/app/ppd"
		And  she enters "plymouth" in the "town" field
		And  she clicks on the "not new-build" checkbox
		And  she enters "1 Apr 2014" in the "min_date" field
		And  she enters "30 Apr 2014" in the "max_date" field
		And  she chooses the "all" radio button
		And  she clicks on the "show results" button
		Then she should retrieve a web page
		And  after upto 20 seconds it should have content "5 Falcon Road, Plymouth, PL1 4GR"
		And  it should have content "69 Millbay Road, Plymouth, PL1 3NG"
		And  it should have content "71 Millbay Road, Plymouth, PL1 3NG"
		And  it should have content "Flat 9, 15 Ridge Park Road, Plymouth, PL7 2FG"
		And  it should have content "3 Verden Close, Plymouth, PL3 4BT"
		And  it should have content "7 Gardeners Lane, Plymouth, PL8 2PJ"
		And  it should have content "10 Gardeners Lane, Plymouth, PL8 2PJ"
		
    
    @javascript
    Scenario:
        Given a visitor
        When she retrieves the page "/app/ppd"
        And  she enters "adam and eve mews" in the "street" field
        And  she chooses the "all" radio button
        And  she clicks on the "show results" button
        Then she should retrieve a web page
        And  it should have content "5 Adam & Eve Mews, London, W8 6UG"