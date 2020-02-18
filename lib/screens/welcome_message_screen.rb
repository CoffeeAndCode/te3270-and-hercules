# frozen_string_literal: true

# After successfully logging in, a welcome screen message is shown.
class WelcomeMessageScreen
  include TE3270

  text_field(:welcome_msg, 8, 23, 33, false)

  def proceed
    send_keys(TE3270.Enter)
  end
end
