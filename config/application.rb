require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sqek
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, :de]
    config.i18n.default_locale = :en

    # allow iframe embedding
    config.action_dispatch.default_headers = {
      'X-Frame-Options'=> 'ALLOWALL'
    }

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    config.app_generators.scaffold_controller :responders_controller
    config.generators do |g|
      g.stylesheets false
    end
  end
end
