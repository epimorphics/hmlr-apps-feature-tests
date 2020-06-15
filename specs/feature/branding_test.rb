require 'test_helper'
require 'byebug'

describe 'HMLR branding' do
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  it 'should verify logo on home page' do
    visit '/'
    page
      .find('img')['src']
      .must_match(/hm_lr_logo/)
  end

  it 'should check the banner on an Elda page' do
    visit '/anything'
    page
      .find('nav.site')
      .matches_style?('background-image' => '../images/hmg-banner.png')
  end
end
