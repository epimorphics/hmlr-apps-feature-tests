# Change log for HMLR apps feature tests

## 2020-06-10

- Integrated the fucntionality of the Cucumber tests into the
  Minitest specs. This gives us the same coverage, but has less
  surface-area to maintain, runs in less than 50% of the time,
  and does not suffer from an annoying bug that we found trying
  to run the Cucumber tests in Firefox 77.x

## 2019-11-19

- switched default browser to Firefox, as Chromium on
  Ubuntu 19.10 gives an error when starting with Selenium
- switched browser driver library from `chromedriver` to
  `webdrivers`
- set rbenv Ruby version to 2.4.9 to match current deployment
  environment
