# frozen_string_literal: true

# A screen displaying TSO Applications available.
class TsoApplicationsScreen
  include TE3270

  text_field(:option, 5, 14, 1)

  def help
    self.option = '5'
    send_keys(TE3270.Enter)
  end

  def im
    self.option = '3'
    send_keys(TE3270.Enter)
  end

  def queue
    self.option = '4'
    send_keys(TE3270.Enter)
  end

  def rfe
    self.option = '1'
    send_keys(TE3270.Enter)
  end

  def rpf
    self.option = '2'
    send_keys(TE3270.Enter)
  end

  def term_test
    self.option = '7'
    send_keys(TE3270.Enter)
  end

  def terminate
    self.option = 'x'
    send_keys(TE3270.Enter)
  end

  def utils
    self.option = '6'
    send_keys(TE3270.Enter)
  end
end
