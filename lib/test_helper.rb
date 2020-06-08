# frozen_string_literal: true

require 'capybara/minitest'
require 'capybara/minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'selenium/webdriver'
require 'hmlr_minitest_helpers'
require 'webdrivers/geckodriver'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Capybara configuration

HOST = ENV['TEST_HOST'] || 'lr-pres-dev-c.epimorphics.net'
PROTO = ENV['TEST_PROTO']&.tr(':', '') || 'http'

Capybara.run_server = false
Capybara.app_host = "#{PROTO}://#{HOST}"

$VERBOSE = nil

# Register a driver for visible Chrome using Selenium
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Register a driver for visible Firefox using Selenium
Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

# Register a driver for headless Chrome using Selenium
Capybara.register_driver :headless_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless!

  Capybara::Selenium::Driver.new(app,
                                 browser: :firefox,
                                 options: options)
end

# To see the browser window while tests are running, set the
# environment var TEST_BROWSER_VISIBLE to 1
browser_visible = ENV['TEST_BROWSER_VISIBLE'] == '1'

# driver = browser_visible ? :chrome : :headless_chrome
driver = browser_visible ? :firefox : :headless_firefox
Capybara.default_driver    = driver
Capybara.javascript_driver = driver
