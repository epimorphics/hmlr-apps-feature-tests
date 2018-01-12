require 'test_helper'

# Integration tests on the UKHPI application
describe 'The home page' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should be reachable from the home page' do
    visit '/'
    page.click_link('UK House Price Index', class: 'lr-header--header-proposition--a')

    page.must_have_title(/UK House Price Index/)
    page.must_have_content(/Use the search tool to find house price trends in the UK/)
    assert includes_css_rules_from?(page, 'application-.+.css$')
  end
end
