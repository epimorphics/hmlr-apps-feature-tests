Feature: empty sparql query

	As LandRegistry

	I want empty queries to redirect to the query form
	
	In order to be helpful to users

	Scenario:
		Given a visitor
		When she retrieves the page "/landregistry/query"
		Then she should retrieve a web page
		And  it should have the title "Welcome to House Price Data from HM Land Registry"
		And  it should have content "EXAMPLE QUERIES"
	