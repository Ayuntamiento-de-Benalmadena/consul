module Consul
  class Application < Rails::Application
    config.i18n.default_locale = :es
    available_locales = ["es", "en"]
    config.i18n.available_locales = available_locales
  end
end
