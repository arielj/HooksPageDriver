# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# Tested 3 methods:
# - using config.before(:each, type: :system) (uncomment the block at line 70)
#   it shows:
#
#   before hook: #<Capybara::RackTest::Driver:0x0000557171583468>
#   2021-12-31 10:53:38 WARN Selenium [DEPRECATION] ....
#   inside test: #<Capybara::Selenium::Driver:0x0000557171677130>

# - using a shared context with a before block (uncomment the shared context at line 55 and line 74)
#
#   shared context before: #<Capybara::RackTest::Driver:0x0000558e34eadbf8>
#   2021-12-31 10:54:57 WARN Selenium [DEPRECATION] ....
#   inside test: #<Capybara::Selenium::Driver:0x0000558e34ef3658>

# - monkeypatching the initialize method of RSpec::Rails::SystemExampleGroup (uncomment it in line 59)
#
#   monkey patching SystemExampleGroup initialize: #<Capybara::RackTest::Driver:0x0000559d137e8258>
#   2021-12-31 10:55:52 WARN Selenium [DEPRECATION] ....
#   monkey patching SystemExampleGroup initialize: #<Capybara::Selenium::Driver:0x0000559d13882498>
#   inside test: #<Capybara::Selenium::Driver:0x0000559d13882498>

# RSpec.shared_context "puts driver" do
#   before { puts "shared context before: #{page.driver}"}
# end

# module RSpec::Rails::SystemExampleGroup
#   def initialize(*args, &blk)
#     super(*args, &blk)

#     self.class.before do
#       puts "monkey patching SystemExampleGroup initialize: #{page.driver}"
#     end
#   end
# end

RSpec.configure do |config|
  # config.before(:each, type: :system) do
  #   puts "before hook: #{page.driver}"
  # end

  # config.include_context "puts driver", type: :system

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
