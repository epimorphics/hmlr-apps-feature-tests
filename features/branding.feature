Feature: branding

	As a Land Registry manager

	I want to ensure that LR web pages conform to Land Registry and data.gov.uk styles
	
	to reassure and avoid confusing users.

    @javascript
    Scenario: verify logo on home page
        Given a visitor
        When she retrieves the home page
        Then she should retrieve a web page
        And  it should have an image matching "lr_logo.*\.png$"

    @javascript
    Scenario: verify HMG banner on Elda page
		Given a visitor
		When she retrieves an elda page
		Then she should retrieve a web page
		And  it should have the title "Search Results"
		And  it should have an HMG banner
	
		
	