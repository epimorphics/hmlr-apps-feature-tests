Feature: download ppd data

	As a visitor

	I want to retrieve information about the house price index for a region

	@javascript
	Scenario:
		Given a visitor
		When she retrieves the page "/app/ppd"
		And  she enters "exeter" in the "town" field
		And  she clicks on the "show results" button
		Then she should retrieve a web page
		Then after upto 10 seconds she clicks on the first "download data" button
		Then she should retrieve a web page
        And  it should have link text "get selected results as CSV with headers" with link ending with ".csv"  