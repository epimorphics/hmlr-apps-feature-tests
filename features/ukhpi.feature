@ukhpi
Feature: ukhpi

	As a visitor

	I want an overview of the uk house price index

	@javascript
	Scenario: visit the landing page
		Given a visitor
		When she retrieves the page "/app/ukhpi"
		Then she should retrieve a web page
		And  it should have the title "UK House Price Index"
		And  it should have rules from stylesheet matching "application.*css"
		And  it should have content "Current index"
		And  she clicks on the "search the UK house price index" link
		Then she should retrieve a web page
        And  it should have the title "UK House Price Index"
        And  it should have rules from stylesheet matching "application.*css"
        And  it should have content "Showing 1 to 12 of"

  @javascript
  Scenario: change the country selection
      Given a visitor
      When she retrieves the page "/app/ukhpi/explore"
      Then she should retrieve a web page
# delay because of https://github.com/epimorphics/ukhpi/issues/99
      And  she waits 2 seconds
      And  she clicks on the change selection button
# delay because of https://github.com/epimorphics/ukhpi/issues/99
      And  she waits 2 seconds
      And  she chooses the "Scotland" radio button
      And  she waits upto 10 seconds for the content "Scotland from" to appear
