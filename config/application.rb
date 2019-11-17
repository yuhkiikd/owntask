require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module OwntaskApp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
    end

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end