require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Ramify
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.active_record.schema_format = :sql
    config.encoding = "utf-8"
    config.filter_parameters += [:password, :password_confirmation]
    config.time_zone = 'Brasilia' 
    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec, :fixture => false, :views => false
    end
    ActiveRecord::Base.include_root_in_json = false
  end
end
