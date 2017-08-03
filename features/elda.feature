Feature: elda page

	As a data consumer

	I want to retrieve data using the linked data api

	to use that data

# check the various formatters are working and returning correct mime type
	# Scenario Outline:
	# 	Given a visitor
	# 	When she retrieves the page "/def/trans/countPeriod"
	# 	And  she clicks on the "<format>" link
	# 	Then she should retrieve a "<mime_type>" file
	#     Examples:
	#     	| format | mime_type               |
	#     	| csv    | text/csv                |
	#     	| json   | application/json        |
	#     	| rdf    | application/rdf\\\\+xml |
	#     	| text   | text/plain              |
	#     	| ttl    | text/turtle             |
	#     	| xml    | application/xml         |
	 
   @javascript
   Scenario:
        Given a visitor
        When she retrieves the page "/data/ppi/transaction/21E5FEB6-76F9-2439-E050-A8C06205342E/current"
        Then she should retrieve a web page
        And  it should have rules from stylesheet matching "/lda-assets/css/result.css$"
        And  it should have content "Additional price paid"

   Scenario:
        Given a visitor
        When she retrieves the page "/data/ppi/transaction/F799167A-933D-4A33-8823-01CB7CFD43BB/current"
        Then she should retrieve a web page
        And  it should have content "Standard price paid"
