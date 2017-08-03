When(/^she retrieves the page "([^"]+)"$/) do |url|
  visit "#{BASE}#{url}"
end

When(/^she enters "([^"]*)" in the "([^"]+)" field$/) do |text, field|
  fill_in(field, with: text)
end

When(/^she selects "([^"]*)" from the "([^"]+)" dropdown$/) do |option, dropdown|
  select(option, from: dropdown)
end

When(/^she clicks on the "(.*)" link$/) do |link|
  click_link(link)
end

When(/^she clicks on the first "(.*)" link$/) do |link_text|
  links = all(:xpath, "//a[normalize-space(.) = '#{link_text}']")
  links[0].click
end

When(/^she clicks on the "(.+)" button$/) do |button|
  click_on(button)
end

When(/^she clicks on the first "(.+)" button$/) do |button_text|
  buttons = all(:xpath, "//a[normalize-space(.) = '#{button_text}']")
  buttons[0].click
end

When(/^she clicks on the "(.+)" checkbox$/) do |box|
  uncheck(box)
end

When(/^she checks the "(.+)" checkbox$/) do |box|
  check(box)
end

When(/^she chooses the "(.+)" radio button$/) do |button|
  choose(button)
end

When(/^she clicks on the "([^"]+)" text$/) do |text|
  find(:xpath, "//*[contains(text(),'#{text}')]").click
end

Then(/^she should retrieve a web page$/) do
end

Then(/^she should retrieve a "([^"]+)" file$/) do |mime_type|
  expect(page.response_headers['Content-Type']).to match(Regexp.new(mime_type))
end

Then(/^it should have the title "(.*)"$/) do |title|
  expect(page.title).to match(Regexp.new("\\s*#{title}\\s*"))
end

Then(/^it should have content "(.*)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^it should have a link "(.*)"$/) do |link|
  expect(page).to have_link(link)
end

Then(/^it should have link text "(.*)" with link ending with "(.*)"$/) do |link_text, ending|
  element = find_link(link_text)
  href = element['href']
  expect(href.split('?')[0]).to end_with(ending)
end

When(/the "(.*)" autocomplete options appear/) do |field|
  page.execute_script %{ $('##{field}').trigger('focus') }
  page.execute_script %{ $('##{field}').trigger('keydown') }
end

Then(/it should have css selector "(.*)"/) do |selector|
  expect(page).to have_css(selector)
end

Then(/it should have rules from stylesheet matching "(.*)"/) do |stylesheet_regex|
  script = %{
    $TEST_RESULT = (function() {
      result = false;
      for ( i=0 ; i < document.styleSheets.length ; i++) {
         stylesheet = document.styleSheets[i]
         if ( stylesheet.href != null && stylesheet.href.match('#{stylesheet_regex}') ) {
           // crude test for whether stylesheet was downloaded
           // fails on empty stylesheets
           result = (stylesheet.cssRules.length > 0);
           break;
         }
      }
       return result;
    })();
  }
  page.execute_script(script)
  result = page.evaluate_script('$TEST_RESULT')
  expect(result).to eq(true)
end

Then(/it should have an image matching "(.*)"/) do |img_url_regex|
  script = %{
    $TEST_RESULT = (function() {
      result = false;
      for ( i=0 ; i < document.images.length ; i++) {
         image = document.images[i]
         if ( image.src.match('#{img_url_regex}').length > 0 ) {
           result = image.complete
           break;
         }
      }
       return result;
    })();
  }
  page.execute_script(script)
  result = page.evaluate_script('$TEST_RESULT')
  expect(result).to eq(true)
end

When(/^she clicks on a random checkbox$/) do
  check_boxes = all(:xpath, "//input[@type='checkbox']")
  check_boxes[rand(0...check_boxes.length - 1)].click
end

When(/^she selects a random radio button$/) do
  check_boxes = all(:xpath, "//input[@type='radio']")
  check_boxes[rand(0...check_boxes.length - 1)].click
end

When(/^she waits upto ([0-9]+) seconds for the link "([^"]*)" to appear/) do |wait_time, text|
  using_wait_time Integer(wait_time) do
    expect(page).to have_link(text)
  end
end

When(/^she waits upto ([0-9]+) seconds for the content "([^"]*)" to appear/) do |wait_time, text|
  using_wait_time Integer(wait_time) do
    expect(page).to have_content(text)
  end
end
