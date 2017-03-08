require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lacerate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # See http://goo.gl/Ar1M61

    config.generators do |generators|
      generators.test_framework  :rspec, fixture: false
      generators.javascripts false
      generators.helper false
      generators.view_specs false
      generators.helper_specs false
      generators.controller_specs false

      generators.model_specs false
      generators.fixtures false

      generators.stylesheets false
      generators.decorator_specs false
      generators.decorator false
    end
  end
end
