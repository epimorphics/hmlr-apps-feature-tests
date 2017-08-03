When(/^she specifies the latest month for which data is available$/) do
  two_months_ago = Date.today << 2
  first_of_month = Date.new(two_months_ago.year, two_months_ago.month, 1)
  last_of_month = (first_of_month >> 1) - 1

  fill_in('min_date', with: first_of_month.strftime('%-d %b %Y'))
  fill_in('max_date', with: last_of_month.strftime('%-d %b %Y'))
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
