require 'test_helper'
require 'byebug'

describe 'PPD download' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'download PPD data' do
    visit '/app/ppd'
    fill_in('town', with: 'exeter')
    click_on('show results')

    using_wait_time(10) do
      click_link('download data', match: :first)

      page
        .find_link('get selected results as CSV with headers')['href']
        .must_match(/\.csv/)
    end
  end
end
