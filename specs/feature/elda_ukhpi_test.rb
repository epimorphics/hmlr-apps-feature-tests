require 'test_helper'
require 'byebug'

describe 'documentation on the linked-data API' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should show that all properties are present' do
    expectations = [
      %r{<link rel="stylesheet" href="/lda-assets/css/result.css" type="text/css">},
      'house price index',
      'house price index cash',
      'house price index detached',
      'house price index existing property',
      'house price index first time buyer',
      'house price index flat maisonette',
      'house price index former owner occupier',
      'house price index mortgage',
      'house price index new build',
      'house price index semi detached',
      'house price index terraced',
      'percentage annual change',
      'percentage annual change cash',
      'percentage annual change detached',
      'percentage annual change existing property',
      'percentage annual change first time buyer',
      'percentage annual change flat maisonette',
      'percentage annual change former owner occupier',
      'percentage annual change mortgage',
      'percentage annual change new build',
      'percentage annual change semi detached',
      'percentage annual change terraced',
      'percentage change',
      'percentage change cash',
      'percentage change detached',
      'percentage change existing property',
      'percentage change first time buyer',
      'percentage change flat maisonette',
      'percentage change former owner occupier',
      'percentage change mortgage',
      'percentage change new build',
      'percentage change semi detached',
      'percentage change terraced',
      'ref month',
      'ref period start',
      'ref period duration',
      'average price',
      'average price cash',
      'average price detached',
      'average price existing property',
      'average price first time buyer',
      'average price flat maisonette',
      'average price former owner occupier',
      'average price mortgage',
      'average price new build',
      'average price semi detached',
      'average price terraced',
      'house price index',
      'house price index cash',
      'house price index detached',
      'house price index existing property',
      'house price index first time buyer',
      'house price index flat maisonette',
      'house price index former owner occupier',
      'house price index mortgage',
      'house price index new build',
      'house price index semi detached',
      'house price index terraced',
      'sales volume',
      'type',
      'UK house price indices',
      'data set',
      'dataset',
      'ref region'
    ]

    visit '/data/ukhpi/region/fylde/month/2013-08'
    body = page.body

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end

  it 'should check that seasonally-adjusted properties are present' do
    expectations = [
      %r{<link rel="stylesheet" href="/lda-assets/css/result.css" type="text/css">},
      'house price index SA',
      'average price SA'
    ]

    visit '/data/ukhpi/region/north-west/month/2015-08'
    body = page.body

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end
end
