# frozen_string_literal: true

# The command entry screen shown in Hercules after dismissing the
# TSO Applications screen.
class CommandScreen
  include TE3270

  text_field(:command, 6, 1, 10)

  def send_command(the_command = 'logoff')
    self.command = the_command
    send_keys(TE3270.Enter)
  end
end
