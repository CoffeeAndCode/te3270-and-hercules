# Example te3270 Gem Project

This project shows how to run [cucumber][cucumber] automated tests with the
[te3270][te3270] gem against a [Hercules][hercules] mainframe ran inside a [Docker container][hercules-docker]. The [Extra][extra] and [BlueZone][bluezone] emulators are both supported.

## Setup

Install [Docker][docker] on your machine. If you are running Windows 10, you will need the
professional version so that it can run Docker containers. During setup of Docker,
make sure to keep using Linux containers and not the Windows container format.

You will also need Ruby installed on your machine which you can get from
[RubyInstaller][rubyinstaller]. This project has been shown to run with Ruby 2.4.9 - 2.6.5
with both x86 and 64 bit installs.

**NOTE: Screenshots can only be taken with the x86 install of Ruby.**

The te3270 gem depends uses the [win32screenshot gem][win32screenshot] which depends on [rautomation][rautomation]
which [does not have 64 bit support](https://github.com/jarmo/RAutomation/issues/68).

**NOTE: Your install of BlueZone Desktop on Windows must match the Ruby architecture you install.**

For example, choose x86 for both or 64 bit for both. Otherwise, the te3270 gem
will be unable to control the BlueZone emulator software.

### Mainframe Session File

Depending on the terminal emulator you'd like to use, you will need to create
a new session that attaches to `127.0.0.1` on port `3270`. You will save the session
to `features/support/` with a file called `MAINFRAME`. The extension will be `.edp`
for the Extra emulator and `.zmd` for the BlueZone emulator.

**NOTE: You will not be able to connect to the session until you start the Docker container in the next step.**

## Running the Cucumber Scenarios

First, you will need to start Hercules in a Docker container. The following
command maps the host `127.0.0.1` to port `3270` and `8038` for a web
interface port.

`docker run --rm -it -p 3270:3270 -p 8038:8038 rattydave/docker-ubuntu-hercules-mvs:latest`

It will take a bit to fully load and will show an ascii art image when it's ready to
connect to.

Once that happens, in another terminal window with Ruby support, you can run
`bundle exec rake` to run the Cucumber scenarios.

## Testing With Multiple Emulators

If you'd like to run some scenarios in one emulator with others in another, you
can mix and match tags. The following will run the first scenario in BlueZone
and the second with Extra.

```gherkin
@mainframe
Feature: Running tests against a 3270 terminal emulator

  @bluezone
  Scenario: Navigating a few screens
    When I navigate to the command screen
    And I type "logoff" on the screen
    Then I should be on the login screen

  @extra
  Scenario: Taking a screenshot
    Given I navigate to the command screen
    And I take a screenshot called "example.png"
    Then I should have a file called "example.png"
    And I type "logoff" on the screen
    Then I should be on the login screen
```

**NOTE: You cannot try to run two emulators at the same time.**

If an emulator is already set, it will be disconnected from before running the
scenario. In the following example, BlueZone will be used by default, but
the second scenario will run inside the Extra emulator since the `@extra` tag's
`Before` hook will be ran second.

```gherkin
@mainframe @bluezone
Feature: Running tests against a 3270 terminal emulator

  Scenario: Navigating a few screens
    When I navigate to the command screen
    And I type "logoff" on the screen
    Then I should be on the login screen

  @extra
  Scenario: Taking a screenshot
    Given I navigate to the command screen
    And I take a screenshot called "example.png"
    Then I should have a file called "example.png"
    And I type "logoff" on the screen
    Then I should be on the login screen
```

## Tips and Tricks

### BlueZone Host Automation Object Documentation

Docmentation can be found at https://www3.rocketsoftware.com/bluezone/help/v71/en/bzsh/bzaa/source/bzaa_acon_bz-host-automation-object.htm

You can also find [error codes](https://www3.rocketsoftware.com/bluezone/help/v71/en/bzsh/bzaa/source/bzaa_aref_error-codes.htm)
that you can use to ignore more error codes while writing to the screen in `:char`
write mode.

```ruby
@emulator = TE3270.emulator_for :bluezone do |platform|
  platform.session_file = "#{__dir__}/MAINFRAME.zmd".gsub('/', '\\')
  platform.write_errors_to_ignore = [6]
  platform.write_method = :char
end
```

### Extra Terminal Emulator Config Setup

When you open an Extra! terminal emulator and disconnect from the server,
the emulator prompts you with a pop-up window to confirm that you want to close
the window which is inconvenient when automating.

You can disable that prompt by going to the emulator's Global Settings/Preferences
and disabling the option to 'confirm disconnect'. Make sure to save the changes.

The next time you open the emulator, the window should automatically close when
you disconnect from the mainframe server.

[bluezone]: https://www.rocketsoftware.com/products/rocket-bluezonepassport-terminal-emulator/rocket-bluezone-terminal-emulation
[cucumber]: https://cucumber.io/
[docker]: https://www.docker.com/
[extra]: https://www.microfocus.com/en-us/products/extra/overview
[hercules]: http://www.hercules-390.eu/
[hercules-docker]: https://hub.docker.com/r/rattydave/docker-ubuntu-hercules-mvs
[rautomation]: https://rubygems.org/gems/rautomation/
[rubyinstaller]: https://rubyinstaller.org/
[te3270]: https://rubygems.org/gems/te3270
[win32screenshot]: https://rubygems.org/gems/win32screenshot/
