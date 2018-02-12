
When(/^she retrieves an elda page$/) do
  visit "#{PROTO}//#{HOST}/anything"
end

Then(/^it should have an HMG banner$/) do
  background_image = page.evaluate_script('$("nav.site").css("background-image")')
  expect(background_image).to match(/url\(.*hmg-banner.png/)
end
