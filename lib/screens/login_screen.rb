# frozen_string_literal: true

# The first part of logging in where you are prompted for your username.
class LoginScreen
  include TE3270

  text_field(:login_prompt, 23, 1, 10, false)
  text_field(:userid, 23, 12, 8)

  def login(user = 'HERC03')
    self.userid = user
    send_keys(TE3270.Enter)
  end
end
