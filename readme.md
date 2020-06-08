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

## Setup

Expected Ruby version is specified in `.ruby-version`. Use [rbenv](https://github.com/rbenv/rbenv)
to manage local Ruby versions on developer machines.

Run `bundle` in the root directory to install Rubygems dependencies.

## Running the tests

Determine which server is going to be tested, e.g. `lr-ppd-dev-pres`*, then

invoke the tests:

```sh
TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

This runs:

- a file download tests
- legacy integration tests written in cucumber
- revised integration tests for the updated UKHPI app, running under MiniTest

## Running the tests on the preproduction server

The preprod server is not visible on the open internet.  To run tests on it an
ssh tunnel must be set up and tests directed to the local end of the tunnel.

The script `bin/test-preprod` sets up a tunnel, runs the tests and then tears down the tunnel.
See the script for various parameters that can be set as environment variables.

An entry in `/etc/hosts` is needed to map `lr-pres-tunnel.epimorphics.net` to `localhost`.

To set up an ssh tunnel manually

```sh
ssh -L ${PORT}:localhost:80 -fN -i ~/.ssh/lr.pem ubuntu@lr-ppd-preprod-pres-1.epimorphics.net
```

This will start an ssh process to implement the tunnel in the background.
The ssh process must be killed when finished.

Point a browser at `http://lr-pres-tunnel.epimorphics.net:${PORT}`.

## Tests dependent on recent data

By default, the tests will omit any tests dependent on there being recent data
available to test against. These tests are tagged in the cucumber features with
`@recent`. To **include** the recent tests in the test run, set the environment
variable `RECENT` to any non-empty value:

```sh
RECENT=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

## Tests that don't work a CI environment

Most tests works in a CI environment, but standard reports tests do not.  To exclude
these tests:

```sh
IN_CI=1 TEST_HOST=lr-ppd-dev-pres.epimorphics.net bin/test
```

This tests the dev server via a load balancer.  To test the server directly use
`lr-ppd-dev-pres-1`.

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
