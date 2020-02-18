# frozen_string_literal: true

# This screen shows the first time a terminal connects to Hercules and
# can be dismissed by sending CLEAR (to unlock keyboard) and RESET.
class MainScreen
  include TE3270

  text_field(:hercules_version, 1, 22, 4, false)
  text_field(:hercules_version_text, 1, 2, 16, false)

  def proceed_to_login
    send_keys(TE3270.Reset)

    # If Hercules has not been interacted with yet, it shows stats about
    # the OS and installation. We need to conditionally skip this screen to
    # get to the login screen.
    send_keys(TE3270.Clear) if hercules_version_text == 'Hercules Version'
  end
end
