Feature: retrieve home page

	As a visitor

	I want to retrieve and read the LR linked data home page
	
	In order to understand what the facilities the site offers
	   and find links to further information and services

    @javascript
	Scenario:
		Given a visitor
		When she retrieves the home page
		Then she should retrieve a web page
		And  it should have rules from stylesheet matching "application-.+.css$"
		And  it should have the title "Welcome to House Price Data from HM Land Registry"
		And  it should have content "HM Land Registry Open Data"
		
	Scenario:
		Given a visitor
		When she retrieves the home page
		And  she clicks on the first "UK House Price Index" link
		Then she should retrieve a web page
		And  it should have the title "UK House Price Index"
		And  it should have content "the average house price in the UK is"
		
	
		
	
		
	