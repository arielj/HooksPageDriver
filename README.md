# README

This sample app shows an issue with Rspec-rails. When running system tests, the `page.driver` is incorrect in before hooks: it's RackTest::Driver instead of Selenium::Driver.

You can try this running `rails spec` for the RSpec specs and `rails test:system` for the Minitest tests.

# Tested 3 methods:

### using config.before(:each, type: :system)

Uncomment the block at line 70 (at spec/rails_helper.rb), run the specs and it shows:

```
before hook: #<Capybara::RackTest::Driver:0x0000557171583468>
2021-12-31 10:53:38 WARN Selenium [DEPRECATION] ....
inside test: #<Capybara::Selenium::Driver:0x0000557171677130>
```

### using a shared context with a before block

Uncomment the shared context at line 55 and line 74 (at spec/rails_helper.rb), it shows:

```
shared context before: #<Capybara::RackTest::Driver:0x0000558e34eadbf8>
2021-12-31 10:54:57 WARN Selenium [DEPRECATION] ....
inside test: #<Capybara::Selenium::Driver:0x0000558e34ef3658>
```

### monkeypatching the initialize method of RSpec::Rails::SystemExampleGroup

Uncomment it in line 59 (at spec/rails_helper.rb), it shows:

```
monkey patching SystemExampleGroup initialize: #<Capybara::RackTest::Driver:0x0000559d137e8258>
2021-12-31 10:55:52 WARN Selenium [DEPRECATION] ....
monkey patching SystemExampleGroup initialize: #<Capybara::Selenium::Driver:0x0000559d13882498>
inside test: #<Capybara::Selenium::Driver:0x0000559d13882498>
```

You can see the initialize is run twice, the first time is wrong but the second time it shows Selenium::Driver.

# Using Minitest, it works

Run the tests using `rails test:system`, it shows:

```
before hooks: #<Capybara::Selenium::Driver:0x000055961e9cc020>
inside test: #<Capybara::Selenium::Driver:0x000055961e9cc020>
```
