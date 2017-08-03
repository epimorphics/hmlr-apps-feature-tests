Feature: sparql form

	As a data user

	I want to execute a SPARQL query using the SPARQL form
	
	In order to be helpful to users

    @javascript
	Scenario:
		Given a visitor
		When she retrieves the page "/app/qonsole"
		Then she should retrieve a web page
		And  it should have the title "Welcome to House Price Data from HM Land Registry"
		And  it should have rules from stylesheet matching "application.*\.css$"
        And  it should have an image matching "lr_logo.*\.png$"
        And  she clicks on the "transactions in a postcode" button
		And  she clicks on the "perform query" button
		And  she waits upto 30 seconds for the content "1 to 10 of" to appear
	