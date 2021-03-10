require 'test_helper'
require 'byebug'

describe 'the SPARQL query form' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'present the SPARQL Qonsole form' do
    visit '/app/qonsole'
    body = page.body
    page.must_have_title('HM Land Registry Open Data')

    expectations = [
      /<link rel="stylesheet"[^>]*application-[0-9a-f]*.css/,
      /lr_logo.*.png/
    ]

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end

  it 'performs a SPARQL query' do
    visit '/app/qonsole'
    click_on('transactions in a postcode')
    click_on('perform query')

    using_wait_time(30) do
      page.must_have_content('1 to 10 of')
    end
  end
end
