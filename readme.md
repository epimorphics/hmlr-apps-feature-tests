# Integration tests for HMLR applications

These tests were abstracted from the `lr-pres` Ops-project repo on 2017-08-03.
Previously the tests were maintained as part of the system operations. In order
to allow other developers to work on maintaining the tests without being
committers to the Ops project, these tests now standalone.

## Setup

Standard Ruby version (as of Aug 2017) is Ruby 2.2.7.

Run `bundle` in the root directory to install Rubygems dependencies.

## Running the tests

Determine which server is going to be tested, e.g. `lr-ppd-dev-pres`*, then

invoke the tests:

    TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test

This runs:

* a file download tests
* legacy integration tests written in cucumber
* revised integration tests for the updated UKHPI app, running under MiniTest


## Running the tests on the preproduction server

The preprod server is not visible on the open internet.  To run tests on it an
ssh tunnel must be set up and tests directed to the local end of the tunnel.

The script bin/test-preprod sets up a tunnel, runs the tests and then tears down the tunnel.
See the script for various parameters that can be set as environment variables.

An entry /etc/hosts to map lr-pres-tunnel.epimorphics.net to localhost.

To set up an ssh tunnel manually

ssh -L ${PORT}:localhost:80 -fN -i ~/.ssh/lr.pem ubuntu@lr-ppd-preprod-pres-1.epimorphics.net

This will start an ssh process to implement the tunnel in the background.  
The ssh process must be killed when finished.

Point a browser at http://lr-pres-tunnel.epimorphics.net:${PORT}.

----------------

* This tests the dev server via a load balancer.  To test the server directly use
lr-ppd-dev-pres-1.


## Tests dependent on recent data

By default, the tests will omit any tests dependent on there being recent data
available to test against. These tests are tagged in the cucumber features with
`@recent`. To **include** the recent tests in the test run, set the environment
variable `RECENT` to any non-empty value:

    RECENT=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test

