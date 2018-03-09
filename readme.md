# Integration tests for HMLR applications

These tests were abstracted from the `lr-pres` Ops-project repo on 2017-08-03.
Previously the tests were maintained as part of the system operations. In order
to allow other developers to work on maintaining the tests without being
committers to the Ops project, these tests now standalone.

## Setup

Standard Ruby version (as of Aug 2017) is Ruby 2.2.7.

Run `bundle` in the root directory to install Rubygems dependencies.

## Running the tests

Determine which server is going to be tested, e.g. `lr-ppd-dev-pres.epimorphics.net`, then
invoke the tests:

    TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test

This runs:

* a file download tests
* legacy integration tests written in cucumber
* revised integration tests for the updated UKHPI app, running under MiniTest

## Tests dependent on recent data

By default, the tests will omit any tests dependent on there being recent data
available to test against. These tests are tagged in the cucumber features with
`@recent`. To **include** the recent tests in the test run, set the environment
variable `RECENT` to any non-empty value:

    RECENT=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
