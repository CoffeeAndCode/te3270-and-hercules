# frozen_string_literal: true

# A screen displaying a random quote and an ASCII art image.
class FortuneCookieScreen
  include TE3270

  def proceed
    send_keys(TE3270.Enter)
  end
end
