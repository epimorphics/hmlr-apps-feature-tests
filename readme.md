# Integration tests for HMLR applications

These tests were abstracted from the `lr-pres` Ops-project repo on 2017-08-03.
Previously the tests were maintained as part of the system operations. In order
to allow other developers to work on maintaining the tests without being
committers to the Ops project, these tests now standalone.

# Running the tests

Testcan be run natively or from within a Docker container.

The container contains all the software components required to run the tests, but not 
the tests themselves. The container mounts the tests and scripts from the current 
directory. Tests and scripts can therefore be modified without rebuilding the container.

## Native Setup

Standard Ruby version (as of Aug 2017) is Ruby 2.2.7.

Run `bundle` in the root directory to install Rubygems dependencies.

## Running the tests natively

Determine which server is going to be tested, e.g. `lr-ppd-dev-pres`*, then

invoke the tests:

    TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test

This runs:

* a file download tests
* legacy integration tests written in cucumber
* revised integration tests for the updated UKHPI app, running under MiniTest

# Docker Setup

- Docker must be installed
- Ensure the user is a member of the docker group
- (Recommended) Install ACR Credentials Helper to interact with the AWS Container
  Registry
- Define env var LR_URL (note this is different to the native tests).

## Running the tests

The operation of the docker image is controlled by a makefile.
This makefile contains instructions to download to previously publish image, build and 
publish a new image, and to run the test.

* make image: builds an image in the local registry.
* make install: pulls an image from the ACR
* make headless: runs the image (the tests) in headless mode
* make gui: runs the image (the tests) in non-headless mode
* make release: pushes a new image to ACR

# Running the tests on the preproduction server

The preprod server is not visible on the open internet.

As an alternative to running over ssh tunnel it may be accessed from Court Lodge via the
hostname lr-staging.epimorphics.net.

## Running via ssh tunnel to preproduction

To run tests on it an ssh tunnel must be set up and tests directed to the local end of 
the tunnel.

The script bin/test-preprod sets up a tunnel, runs the tests and then tears down the tunnel.
See the script for various parameters that can be set as environment variables.

An entry /etc/hosts to map lr-pres-tunnel.epimorphics.net to localhost.

To set up an ssh tunnel manually

ssh -L ${PORT}:localhost:80 -fN -i ~/.ssh/lr.pem ubuntu@lr-ppd-preprod-pres-1.epimorphics.net

This will start an ssh process to implement the tunnel in the background.  
The ssh process must be killed when finished.

Point a browser at http://lr-pres-tunnel.epimorphics.net:${PORT}.


## Tests dependent on recent data

By default, the tests will omit any tests dependent on there being recent data
available to test against. These tests are tagged in the cucumber features with
`@recent`. To **include** the recent tests in the test run, set the environment
variable `RECENT` to any non-empty value:

    RECENT=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
    
## Tests that don't work a CI environment

Most tests works in a CI environment, but standard reports tests do not.  To exclude
these tests:

    IN_CI=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
    

----------------

* This tests the dev server via a load balancer.  To test the server directly use
lr-ppd-dev-pres-1.

