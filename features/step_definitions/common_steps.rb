When(/^she specifies the latest month for which data is available$/) do
  dayInMonth = Date.today << 2 # 2 months before
  first = Date.new year=dayInMonth.year, month=dayInMonth.month, mday=1
  last  = (first >> 1) - 1
  fill_in('min_date', :with => first.strftime('%-d %b %Y'))
  fill_in('max_date', :with => last.strftime('%-d %b %Y'))
end

Then(/^it should have at least one address$/) do
  expect(page).to have_xpath("//span[@class='address']")
end

When(/^she waits (\d+) seconds$/) do |delay|
  sleep delay.to_i
end


When(/^she waits 1 second$/) do
  sleep 1
end
