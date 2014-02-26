require 'boot'

env = ENV['RACK_ENV'] || "development"

Bundler.require :default, env

module Application
  include ActiveSupport::Configurable
end

Application.configure do |config|
  config.root     = File.dirname(__FILE__)
  config.env      = ActiveSupport::StringInquirer.new(env.to_s)
end

# Load Active Record and database.yml
db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)[Application.config.env]
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.establish_connection(db_config)

# Load specific environments
specific_environment = "../environments/#{Application.config.env}.rb"
require specific_environment if File.exists? specific_environment

# Load initializers
files = "config/initializers/**/*.rb"
Dir[files].each {|f| require f}
# Load models
files = "#{File.dirname(__FILE__)}/../app/models/*.rb"
Dir[files].each {|f| require f}
# Load api
files = "#{File.dirname(__FILE__)}/../app/api/*.rb"
Dir[files].each {|f| require f}

ActiveRecord::Base.instance_eval do
  include ActiveModel::MassAssignmentSecurity
  attr_accessible []
end

require File.expand_path('../../api', __FILE__)
