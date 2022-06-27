require 'test_helper'
require 'byebug'

describe 'The Fees Calculator app' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should retrieve and read the fees calculator page' do
    visit '/fees-calculator.html'
    page.must_have_title('Fees Calculator')
    page.must_have_content('Fee calculator')
  end

  # it 'should have the expected image and style assets' do
  #   expectations = [
  #     /HMLR_logo.*\.png/,
  #     %r{<link href="stylesheets/normalize.css" rel="stylesheet" type="text/css">},
  #     %r{<link href="stylesheets/global.css" rel="stylesheet" type="text/css">},
  #     %r{<link href="stylesheets/fc_style.css" rel="stylesheet" type="text/css">},
  #   ]

  #   visit '/fees-calculator.html'
  #   body = page.body

  #   expectations.each do |expectation|
  #     body.must_match(expectation)
  #   end
  # end
end
