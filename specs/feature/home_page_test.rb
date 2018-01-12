require 'test_helper'

# Home page tests
describe 'The home page' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should have the expected static content' do
    visit '/'
    page.must_have_title(/Welcome to House Price Data from HM Land Registry/)
    page.must_have_content(/HM Land Registry Open Data/)
    assert includes_css_rules_from?(page, 'application-.+.css$')
  end
end
