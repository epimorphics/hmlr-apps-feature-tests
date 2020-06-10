require 'test_helper'
require 'byebug'

describe 'the Lucene text index' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should allow common stop words' do
    visit '/app/ppd'
    fill_in('town', with: 'plymouth')
    fill_in('street', with: 'the')
    fill_in('min_date', with: '1 Apr 2014')
    fill_in('max_date', with: '30 Apr 2014')
    choose('all')
    click_on('show results')

    using_wait_time(20) do
      page.must_have_content('1B The Dell, Plymouth, PL7 4PS')
      page.must_have_content('Basement, 2A The Esplanade, Plymouth, PL1 2PJ')
    end
  end

  it 'find common stop words in recent data' do
    if ENV['RECENT']
      two_months_ago = Date.today.prev_month(2)
      first_of_month = two_months_ago.prev_day(two_months_ago.mday - 1)
      last_of_month = two_months_ago.next_month.prev_day(two_months_ago.next_month.mday)

      visit '/app/ppd'
      fill_in('town', with: 'plymouth')
      fill_in('street', with: 'the')
      fill_in('min_date', with: first_of_month.strftime('%-d %b %Y'))
      fill_in('max_date', with: last_of_month.strftime('%-d %b %Y'))

      choose('all')
      click_on('show results')

      using_wait_time(20) do
        page.must_have_xpath("//span[@class='address']")
      end
    end
  end
end
