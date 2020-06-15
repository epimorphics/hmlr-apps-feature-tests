require 'test_helper'
require 'byebug'

describe 'The SPARQL query form' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should redirect empty queries to the query form' do
    visit '/landregistry/query'
    page.must_have_content('HM Land Registry Open Data')
    page.must_have_content('EXAMPLE QUERIES')
  end
end
