require 'test_helper'

describe 'Additional price-paid information' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should retrieve information for a postcode' do
    visit '/app/ppd'
    fill_in('postcode', with: 'AL7 1AJ')
    uncheck('detached')
    uncheck('semi-detached')
    uncheck('terraced')
    uncheck('flat/maisonette')
    choose('all')
    click_on('show results')
    page.must_have_content('8 Brownfields Court, Welwyn Garden City, AL7 1AJ')
  end

  it 'should retrieve the information for a postcode' do
    visit '/app/ppd'
    fill_in('postcode', with: 'AL7 1BX')
    uncheck('other')
    choose('all')
    click_on('show results')
    page.must_have_content('1 The Swallows, Welwyn Garden City, AL7 1BX')
  end
end
