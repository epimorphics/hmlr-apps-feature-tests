Feature: text index

	As a visitor

	I want the text index to work properly when searching for data
	

	Scenario: common stop words not stopped and multiple search constraints work
		Given a visitor
		When she retrieves the page "/app/ppd"
		And  she enters "plymouth" in the "town" field
		And  she enters "the" in the "street" field
		And  she enters "1 Apr 2014" in the "min_date" field
		And  she enters "30 Apr 2014" in the "max_date" field
		And  she chooses the "all" radio button
		And  she clicks on the "show results" button
		Then she should retrieve a web page
		And  it should have content "1B The Dell, Plymouth, PL7 4PS"
		And  it should have content "Basement, 2A The Esplanade, Plymouth, PL1 2PJ"
		
		
	@recent
	Scenario: common stop words not stopped and multiple search constraints work in recent data
		Given a visitor
		When she retrieves the page "/app/ppd"
		And  she enters "the" in the "street" field
		And  she specifies the latest month for which data is available
		And  she clicks on the "show results" button
		Then she should retrieve a web page
		And  it should have at least one address
		
		
	
		
	