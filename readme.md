# Feature tests for HMLR applications

These tests perform various system or application tests on the HMLR linked-data
applications: UKHPI, PPD, and Standard-Reports. The goals of these tests are
multi-fold:

- to perform a suite of system-level tests to guard against regressions during
  app software development
- to perform liveness and non-regression tests on running systems, e.g. during
  OS upgrades or other ops-level operations
- to perform specific system-level characteristics, such as the behaviour of
  Apache `mod-QoS`.

By setting environment variables, different aspects of the test behaviours can
be controlled in any given instance. See below for details.

## History

These tests were abstracted from the `lr-pres` Ops-project repo on 2017-08-03.
Previously the tests were maintained as part of the system operations. In order
to allow other developers to work on maintaining the tests without being
committers to the Ops project, these tests now standalone.

## Running the tests

There are two ways to run the tests, either in a docker container or natively.

The docker container provides a stable software environment for running the tests.
Running natively does not require docker to be installed.

## Running with Docker

### Docker Setup

- Docker must be installed and the docker daemon running
- either build your own test image with `make test-image`
- or set up access to the LR container image registry (see below) and run
  `make install-test-image` to install the container from the registry
  
To access the LR container image registry, AWS credentials need to be installed
and configured.  Access the LR container image registry is needed to download
a prebuilt container or to publish a new container to the registry.

- create an AWS profile for an IAM user with access to the LR container registry
- see [Amazon AWS credentials documentation](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/guide_credentials_profiles.html)
  - By default the scripts in this directory will use the profile name `lr`,
but this can be changed to a name of your choice with
`export AWS_PROFILE=<profile name>`
- install the aws credentials helper - this will automatically log your docker
daemon into the LR container registry - see [Amazon AWS credentials helper
documentation](https://github.com/awslabs/amazon-ecr-credential-helper/blob/master/README.md)

### Running the tests in a docker container

Standard test configurations can be run using make:

- `make test-dev`
- `make test-preprod`
- `make test-production`

Alternatively the test scripts can be run directly, e.g.

```sh
    TEST_HOST=lr-ppd-dev-pres-1.epimorphics.net bin/dkr-test
```

or

```sh
   TEST_URL=http://lr-ppd-dev-pres-1.epimorphics.net bin/dkr-test
```

When using docker, the docker image provides only the test environment and software.
The tests and tests scripts are as defined in the native file system. Any local edits
to the tests and scripts will be executed by the container.

To get an interactive bash shell in the docker container, e.g. for debugging:

```sh
    TEST_CMD="bash -" bin/dkr-test
```

Other environment variables that control the execution of the tests are as
described below.

## Running Natively

### Setup

Expected Ruby version is specified in `.ruby-version`. Use [rbenv](https://github.com/rbenv/rbenv)
to manage local Ruby versions on developer machines.

Run `bundle` in the root directory to install Rubygems dependencies.

### Running the tests Natively

Determine which server is going to be tested, e.g. `lr-ppd-dev-pres-1`, then

invoke the tests:

```sh
    TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

This runs:

- a file download test
- integration tests for UKHPI, PPD and Standard-Reports apps
- a mod-QoS test

The service to test can also be a load-balancer, but note that the mod-QoS tests
do not work in this case. To use a load-balacer as the `TEST_HOST`, set the `TEST_LB`
environment variable:

```sh
TEST_LB=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

## Environment Variables

### Tests dependent on recent data

By default, the tests will omit any tests dependent on there being recent data
available to test against.  To **include** the recent tests in the test run, set the environment
variable `RECENT` to any non-empty value:

```sh
    RECENT=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

### Tests that don't work a CI environment

Most tests works in a CI environment, but standard reports tests do not.  To exclude
these tests:

```sh
    IN_CI=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

### Testing via a Load Balancer

Some tests, such as the quality of service tests, do not work via a load balancer.
To disable these tests set the `TEST_LB` environment variable to true:

```sh
   TEST_LB=true TEST_URL=https://landregistry.data.gov.uk bin/test
```

## Building the Docker Image

`make test-container-image` will build the test container image locally.

`make release-test-image` will push a locally built container image to the LR
container registry.

The registry will not allow redefining an existing tag
so the container version defined in `bin/dkr-config` must be updated before the
the new container image is built and pushed.

## Running the tests on the preproduction server

The preprod server is not visible on the open internet.  To run tests on it an
ssh tunnel must be set up and tests directed to the local end of the tunnel.

The scripts `bin/test-preprod` and bin/dkr-test-preprod set up a tunnel,
run the tests and then tear down the tunnel.

See the script for various parameters that can be set as environment variables.

An entry in `/etc/hosts` is needed to map `lr-pres-tunnel.epimorphics.net` to `localhost`.

To set up an ssh tunnel manually

```sh
ssh -L ${PORT}:localhost:80 -fN -i ~/.ssh/lr.pem ubuntu@lr-ppd-preprod-pres-1.epimorphics.net
```

This will start an ssh process to implement the tunnel in the background.
The ssh process must be killed when finished.

Point a browser at `http://lr-pres-tunnel.epimorphics.net:${PORT}`.

## Full list of test options

| Option                 | Value      | Meaning                                     |
|------------------------|------------|---------------------------------------------|
| `TEST_HOST`            | _required_ | The server to run the tests against         |
| `TEST_PROTO`           |            | Default protocol is `http`                  |
| `TEST_PROTO`           | https      | Use `https` to acces `TEST_HOST`            |
| `IN_CI`                |            | Tests not running in CI                     |
| `IN_CI`                | 1          | Tests *are* running in CI                   |
| `RECENT`               |            | Do *not* include tests that use recent data |
| `RECENT`               | 1          | *Do* include tests that use recent data     |
| `TEST_BROWSER_VISIBLE` |            | Use a headless browser to test              |
| `TEST_BROWSER_VISIBLE` | 1          | Show the browser (e.g. for debugging)       |
| `TEST_LB`              |            | Not testing a load-balancer, so test modQoS |
| `TEST_LB`              | 1          | Testing load balancer, so do not test modQoS|
