Feature: documentation

	As a visitor

	I want to read detailed documentation about the linked data
	

	Scenario:
		Given a visitor
		When she retrieves the page "/hpi-documentation.html"
		Then she should retrieve a web page
		And  it should have content "House Price Index Linked Data"
		
	Scenario:
		Given a visitor
		When she retrieves the page "/ppd-documentation.html"
		Then she should retrieve a web page
		And  it should have content "Price Paid Linked Data"
		
	