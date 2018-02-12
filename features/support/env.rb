require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'byebug'

# Pass the test host in from the environment
HOST = ENV['TEST_HOST'] || '10.10.10.10'
PROTO = ENV['TEST_PROTO'] || 'http:'
if ! PROTO.end_with? ":"
  PROTO = PROTO + ":"
end
BASE = ''.freeze
Capybara.run_server = false
Capybara.app_host = "#{PROTO}//#{HOST}"

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
see_visible_window_while_test_run = false
driver = see_visible_window_while_test_run ? :chrome : :headless_chrome
Capybara.default_driver    = driver
Capybara.javascript_driver = driver

# Enable adding a breakpoint into steps
Then(/^breakpoint$/) do
  byebug # rubocop:disable Lint/Debugger
  puts 'resuming ...'
end

# Check the browser console.log after the scenario runs. If it's not empty,
# show it as output
After do |scenario|
  console_logs = page.driver.browser.manage.logs.get(:browser)

  unless !console_logs || console_logs.empty?
    puts "'#{scenario.name}' -- console log contains:"
    console_logs.each do |log|
      puts log.inspect
    end
  end
end
