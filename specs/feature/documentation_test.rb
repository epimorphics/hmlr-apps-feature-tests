require 'test_helper'
require 'byebug'

describe 'documentation about linked data' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should show the documentation on HPI' do
    visit '/hpi-documentation.html'
    page
      .must_have_content('House Price Index Linked Data')
  end

  it 'should show the documentation on HPI' do
    visit '/ppd-documentation.html'
    page
      .must_have_content('Price Paid Linked Data')
  end
end
