# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec'
require 'require_all'
require 'TE3270'

require_all 'lib'

World(TE3270::ScreenFactory)

TE3270::ScreenFactory.routes = {
  default: [
    [MainScreen, :proceed_to_login],
    [LoginScreen, :login],
    [PasswordEntryScreen, :login],
    [WelcomeMessageScreen, :proceed],
    [FortuneCookieScreen, :proceed],
    [TsoApplicationsScreen, :terminate],
    [CommandScreen, :send_command]
  ]
}
