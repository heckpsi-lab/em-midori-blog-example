require 'bundler'
Bundler.require
require 'yaml'
require 'json'
require 'em-midori/extension/sequel'

Dir[File.dirname(__FILE__) + '/middlewares/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/routes/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/services/*.rb'].each {|file| require file }

Midori::Configure.before = proc do
  DATABASE = Sequel.connect(YAML.load_file('config/db.yml')['development'])
  Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
end

define_error :unauthorized_error, :resource_conflict

class Route < Midori::API
  use CookieMiddleware

  helper :content_type do |val|
    header['Content-Type'] = val
  end

  capture UnauthorizedError do
    Midori::Response.new(401,
                         {},
                         {code: 401,
                          msg: 'User not existed or password incorrect.'
                         }.to_json)
  end

  capture ResourceConflict do
    Midori::Response.new(409,
                         {},
                         {code: 409,
                          msg: 'Resource has been occupied'
                         }.to_json)
  end

  mount '/post', PostRoute
  mount '/user', UserRoute
  mount '/static', StaticRoute # NOT SAFE, DEVELOPMENT ONLY, use nginx as static server in production
end

Midori::Runner.new(Route).start