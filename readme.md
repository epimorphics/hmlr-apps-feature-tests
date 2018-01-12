# Integration tests for HMLR applications

These tests were abstracted from the `lr-pres` Ops-project repo on 2017-08-03.
Previously the tests were maintained as part of the system operations. In order
to allow other developers to work on maintaining the tests without being
committers to the Ops project, these tests now standalone.

## Setup

Standard Ruby version (as of Aug 2017) is Ruby 2.2.7.

Run `bundle` in the root directory to install Rubygems dependencies.

## Running the tests

Determine which server is going to be tested, e.g. `lr-pres-dev-c`, then
invoke the tests:

    TEST_HOST=lr-pres-dev-c.epimorphics.net bin/test

This runs:

* a file download tests
* legacy integration tests written in cucumber
* revised integration tests for the updated UKHPI app, running under MiniTest
