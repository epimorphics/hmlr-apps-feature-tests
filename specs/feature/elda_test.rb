require 'test_helper'
require 'byebug'

describe 'The linked data API' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should retrieve a PPD transaction' do
    expectations = [
      %r{<link rel="stylesheet" href="/lda-assets/css/result.css" type="text/css">},
      'Standard price paid'
    ]

    visit '/data/ppi/transaction/F799167A-933D-4A33-8823-01CB7CFD43BB/current'
    body = page.body

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end

  it 'should retrieve an APPD transaction' do
    expectations = [
      %r{<link rel="stylesheet" href="/lda-assets/css/result.css" type="text/css">},
      'Additional price paid'
    ]

    visit '/data/ppi/transaction/21E5FEB6-76F9-2439-E050-A8C06205342E/current'
    body = page.body

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end
end
