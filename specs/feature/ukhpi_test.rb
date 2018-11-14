require 'test_helper'

# Integration tests on the UKHPI application
describe 'The UKHPI application' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should be reachable from the home page' do
    visit '/'
    page.click_link('UK House Price Index', class: 'lr-header--header-proposition--a')
    page.must_have_title(/UK House Price Index/)
  end

  it 'should have the correct static content' do
    visit '/app/ukhpi'

    page.must_have_title(/UK House Price Index/)
    page.must_have_content(/Use the search tool to find house price trends in the UK/)
    assert includes_css_rules_from?(page, 'application-.+.css$')
  end

  it 'should show figures for the current headline average price and monthly change' do
    visit '/app/ukhpi'

    page
      .find('.c-headline-figure__average-price')
      .must_have_content(/£([[[:digit:]],])+/)
    page
      .find('.c-headline-figure__monthly-change')
      .must_have_content(/(remained the same)|((fallen|risen) by ([[[:digit:]]\.]+)%)/)
  end

  it 'should be able to reach the application from the landing page' do
    visit '/app/ukhpi'
    page.click_link('search the UK house price index', class: 'c-search-tool')

    page
      .must_have_title(/UK House Price Index/)
    page
      .find('h1')
      .must_have_content('House Price Statistics')
  end

  it 'redirects from the old /explore URL to /browse' do
    visit '/app/ukhpi/explore'
    page.must_have_current_path(%r{/app/ukhpi/browse})
  end

  it 'shows United Kingdom figures by default' do
    visit '/app/ukhpi/browse'
    page
      .all('.c-options-selection__button')
      .first
      .must_have_content('United Kingdom')
  end

  it 'allows the user to select a different location' do
    visit '/app/ukhpi/browse'
    page
      .all('.c-options-selection__button')
      .first
      .click

    page
      .find('.el-input input')
      .send_keys('scotland')

    page
      .click_button('Confirm')

    page
      .all('.c-options-selection__button')
      .first
      .must_have_content('Scotland')
  end
end
