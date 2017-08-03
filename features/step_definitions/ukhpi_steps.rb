When(/^she clicks on the change selection button$/) do
  buttons = all(:xpath, "//button/span[normalize-space(.) = 'customise your search']")
  buttons[0].click
end
