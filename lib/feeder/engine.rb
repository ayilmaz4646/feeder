module Feeder
  class Engine < ::Rails::Engine
    isolate_namespace Feeder
    config.i18n.default_locale = "en"
    config.i18n.load_path += Dir[config.root.join('locales', '*.{yml}').to_s]

    initializer "feeder.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        helper Feeder::FeedsHelper
      	helper Feeder::SitesHelper
      end
    end

    config.generators do |g|
      g.test_framework :mini_test, spec: true, fixture: false
    end
  end
end
