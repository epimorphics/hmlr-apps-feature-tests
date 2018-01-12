require 'capybara/minitest'
require 'capybara/minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'selenium/webdriver'
require 'hmlr_minitest_helpers'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Capybara configuration

HOST = ENV['TEST_HOST'] || 'lr-pres-dev-c.epimorphics.net'
Capybara.run_server = false
Capybara.app_host = "http://#{HOST}"

$VERBOSE = nil

# Register a driver for visible Chrome using Selenium
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Register a driver for headless Chrome using Selenium
Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] },
    loggingPrefs: { browser: 'ALL' }
  )

  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities)
end

# To see the Chrome window while tests are running, set this var to true
see_visible_window_while_test_run = ENV['TEST_BROWSER_VISIBLE']
driver = see_visible_window_while_test_run ? :chrome : :headless_chrome
Capybara.default_driver    = driver
Capybara.javascript_driver = driver
