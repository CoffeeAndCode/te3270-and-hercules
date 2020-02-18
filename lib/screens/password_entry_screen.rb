# frozen_string_literal: true

# The second part of logging in when prompted for the password associated
# with the username provided from the LoginScreen.
class PasswordEntryScreen
  include TE3270

  text_field(:password, 2, 2, 8)
  text_field(:password_prompt, 1, 2, 27, false)

  def login(password = 'PASS4U')
    self.password = password
    send_keys(TE3270.Enter)
  end
end
