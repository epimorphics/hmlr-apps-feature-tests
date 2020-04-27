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
```
    TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```
or
```
   TEST_URL=http://lr-ppd-dev-pres.epimorphics.net bin/test
```

This runs:

* a file download tests
* legacy integration tests written in cucumber
* revised integration tests for the updated UKHPI app, running under MiniTest

### Tests dependent on recent data

By default, the tests will omit any tests dependent on there being recent data
available to test against. These tests are tagged in the cucumber features with
`@recent`. To **include** the recent tests in the test run, set the environment
variable `RECENT` to any non-empty value:

    RECENT=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
    
### Tests that don't work a CI environment

Most tests works in a CI environment, but standard reports tests do not.  To exclude
these tests:

    IN_CI=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test

### Testing via a Load Balancer

Some tests, such as the quality of service tests, do not work via a load balancer.
To disable these tests set the `TEST_LB` environment variable to true:
```
   TEST_LB=true TEST_URL=https://landregistry.data.gov.uk bin/test
```

## Running the tests in a Docker container

The tests can be run using a Docker container. The container contains all the
software components required to run the tests, but not the tests themselves.

When the container is run from the root directory of this repository, it mounts
the tests and scripts from the current directory into the container file
space.  Tests and scripts can therefore modified without rebuilding the container.

### Installing the container on the local image

- Docker must be installed
- the aws credentials helper should be installed and configured - 
  see https://github.com/awslabs/amazon-ecr-credential-helper/blob/master/README.md
- to download the container `make install-test-container`

### Running the tests using a container

This can be done using make:

- `make test-dev` will test the dev server
- `make test-preprod` will test the preprod server
- `make test-production` will test the production service

Make can also be used to test an individual server:

- `make test-server TEST_URL=...` will test that URL directly
   - e.g. `make test-server TEST_URL=http://lr-ppd-production-pres-1.epimorphics.net`

The test scripts can be run directly, which may give a bit more control over the test run:

- cd to the root directory of this project
- `bin/dkr-test`
     - takes the same arguments and environment variable as `bin/test`; see above

To open a bash shell in an instance of the test container, run

```
    TEST_CMD="bash -" bin/dkr-test
```

### Building a test container from scratch

`test-container-image` will build the test container image locally.

`release-test-container` will push a locally built container image to the LR EKS container registry.

The registry will not allow redefining an existing tag
so the container version defined in `bin/dkr-config` must be updated before the
the new container image is built and pushed.

## Running the tests on the preproduction server

The preprod server is not visible on the open internet.  To run tests on it an
ssh tunnel must be set up and tests directed to the local end of the tunnel.

The script bin/test-preprod sets up a tunnel, runs the tests and then tears down the tunnel.
See the script for various parameters that can be set as environment variables.

The equivalent script to run the tests using a container is `bin/dkr-test-preprod`

Point a browser at http://lr-pres-tunnel.epimorphics.net:${PORT}.




----------------

* This tests the dev server via a load balancer.  To test the server directly use
lr-ppd-dev-pres-1.

