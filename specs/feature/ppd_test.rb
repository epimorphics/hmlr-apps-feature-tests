require 'test_helper'
require 'byebug'

describe 'price paid data for houses' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should render the page with correct assets' do
    expectations = [
      %r{<link rel="stylesheet" media="all" href="/app/ppd/assets/application.*.css"},
      /<img[^>]*hm_lr_logo[^>]*>/
    ]

    visit '/app/ppd'
    body = page.body

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end

  it 'should find some results for a time period and build type' do
    visit '/app/ppd'
    fill_in('town', with: 'plymouth')
    uncheck('not new-build')
    fill_in('min_date', with: '1 Apr 2014')
    fill_in('max_date', with: '30 Apr 2014')
    choose('all')
    click_on('show results')

    using_wait_time(20) do
      page.must_have_content('69 Millbay Road, Plymouth, PL1 3NG')
      page.must_have_content('71 Millbay Road, Plymouth, PL1 3NG')
      page.must_have_content('Flat 9, 15 Ridge Park Road, Plymouth, PL7 2FG')
      page.must_have_content('3 Verden Close, Plymouth, PL3 4BT')
      page.must_have_content('7 Gardeners Lane, Plymouth, PL8 2PJ')
      page.must_have_content('10 Gardeners Lane, Plymouth, PL8 2PJ')
    end
  end

  it 'should return results when the search contains &' do
    visit '/app/ppd'
    fill_in('street', with: 'adam and eve mews')
    choose('all')
    click_on('show results')
    page.must_have_content('5 Adam & Eve Mews, London, W8 6UG')
  end
end
