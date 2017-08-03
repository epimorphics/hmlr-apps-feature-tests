require 'capybara'
require 'capybara/cucumber'
#require 'capybara/mechanize/cucumber'
require 'capybara/rspec'
require 'capybara/poltergeist'
#require 'capybara-webkit'

require 'byebug'

HOST = ENV['TEST_HOST'] || '10.10.10.10'
BASE = "http://#{HOST}"

Capybara.app = "make sure this isn't nil"
#Capybara.javascript_driver = :selenium
Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, :js_errors => false )
  Capybara::Poltergeist::Driver.new(app, :timeout => 120 )
  
end
Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist
#Capybara.javascript_driver = :webkit

Then(/^breakpoint$/) do
  byebug
  puts 'resuming ...'
end

##if Capybara.current_driver == :selenium
#  require 'headless'
#
#  headless = Headless.new
#  headless.start
##end