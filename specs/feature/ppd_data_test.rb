require 'test_helper'
require 'byebug'

describe 'PPD datasets' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should be able to download the monthly PPD datasets' do
    visit '/ppd-data.html'
    page.must_have_title('Download Price Paid Data')
    page.must_have_content('Price paid data download options')
  end
end
