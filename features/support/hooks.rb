# frozen_string_literal: true

Before('@bluezone') do
  TE3270.disconnect(@emulator) unless @emulator.nil?

  @emulator = TE3270.emulator_for :bluezone do |platform|
    platform.session_file = "#{__dir__}/MAINFRAME.zmd".gsub('/', '\\')
    platform.window_state = :normal
    platform.write_errors_to_ignore = [6]
    platform.write_method = :char
    platform.visible = true
  end
end

Before('@extra') do
  TE3270.disconnect(@emulator) unless @emulator.nil?

  @emulator = TE3270.emulator_for :extra do |platform|
    platform.session_file = "#{__dir__}/MAINFRAME.EDP".gsub('/', '\\')
    platform.window_state = :normal
    platform.visible = true
  end
end

After('@mainframe') do
  TE3270.disconnect(@emulator)
  @emulator = nil
  sleep 1
end
