require_relative "boot"
require "rails/all"
require "csv"
Bundler.require(*Rails.groups)

module EcommerceHome
  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join("lib/cookie_products")
    config.eager_load_paths << Rails.root.join("lib/session_cart")
  end
end
