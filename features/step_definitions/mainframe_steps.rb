# frozen_string_literal: true

When(/^I navigate to the command screen$/) do
  navigate_to(CommandScreen)
end

And(/^I should have a file called "([^"]*)"$/) do |filename|
  expect(File.exist?(filename)).to eq(true)
end

And(/^I take a screenshot called "([^"]*)"$/) do |filename|
  @emulator.screenshot(filename)
end

And(/^I type "([^"]*)" on the screen$/) do |command|
  on(CommandScreen).send_command(command)
end

Then(/^I should be on the login screen$/) do
  expect(on(LoginScreen).login_prompt).to eq('Logon ===>')
end
