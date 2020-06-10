require 'test_helper'
require 'byebug'

describe 'the Standard Reports workflow' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def random_input(input_type)
    all(:xpath, "//input[@type='#{input_type}']")
      .to_a
      .sample
  end

  it 'presents the standard reports form' do
    visit '/app/standard-reports'
    body = page.body
    page.must_have_title('HM Land Registry house price data')

    expectations = [
      /<link rel="stylesheet"[^>]*application-[0-9a-f]*.css/,
      /lr_logo.*.png/
    ]

    expectations.each do |expectation|
      body.must_match(expectation)
    end
  end

  it 'generates a standard report' do
    unless ENV['IN_CI']
      visit '/app/standard-reports'
      click_on('create a standard report')

      choose('report_avgPrice')
      click_on('Next')

      choose('areaType_pcSector')
      click_on('Next')

      fill_in('area', with: 'BS20 6')
      click_on('Next')

      click_on('Next')

      # click_link('More dates')
      page.find('details summary').click
      random_input('checkbox').click
      click_on('Next')

      random_input('radio').click
      click_on('Next')

      click_on('Generate report')

      using_wait_time(60) do
        page.must_have_link('open-data (csv) format')
      end
    end
  end
end
