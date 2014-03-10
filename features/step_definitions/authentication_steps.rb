Given(/^a user visits the signin page$/) do
  visit signin_path
end

When(/^they submit invalid signin information$/) do
  click_button "Submit"
end

Then(/^they should see an error message$/) do
  expect(page).to have_content('Invalid email/password combination')
end

Given(/^the user has an account$/) do
  @user = User.create(name: "Andrew Yiu", email: "ayiu@pivotallabs.com", password: "xtremer1", password_confirmation: "xtremer1")
end

When(/^the user submits valid signin information$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Submit"
end

Then(/^they should see their profile page$/) do
	expect(page).to have_content(@user.name)
	expect(page).to have_content(@user.email)
	expect(page).to have_content('Information')
end

Then(/^they should see a signout link$/) do
  expect(page).to have_link('Sign Out', href: signout_path)
	expect(page).to_not have_link('Sign In', href: signin_path)
end
