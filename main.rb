require 'bundler'
Bundler.require
require 'yaml'
require 'em-midori/extension/sequel'

Dir[File.dirname(__FILE__) + '/routes/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/services/*.rb'].each {|file| require file }

Midori::Configure.before = proc do
  DATABASE = Sequel.connect(YAML.load_file('config/db.yml')['development'])
  Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
end

class Route < Midori::API
  mount '/api', APIRoute
  mount '/admin', AdminRoute
  mount '/static', StaticRoute # NOT SAFE, DEVELOPMENT ONLY, use nginx as static server in production
end

Midori::Runner.new(Route).start