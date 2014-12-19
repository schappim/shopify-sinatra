#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
require 'mongo_mapper'
require 'yaml'
require 'sinatra'
require 'omniauth-oauth2'
require 'omniauth-shopify-oauth2'
require 'shopify_api'

require './models/shop.rb'
require './models/log.rb'

CONFIG = YAML::load( File.open( 'config.yaml' ) )
#puts CONFIG.inspect

MongoMapper.connection = Mongo::Connection.new(CONFIG["server"], CONFIG["port"])
MongoMapper.database = CONFIG["database"]
MongoMapper.database.authenticate(CONFIG["db_username"], CONFIG["db_password"])

def logged_using_omniauth? request
  omniauth = request.env["omniauth.auth"]
  if request.env["omniauth.auth"]
    if omniauth[:credentials][:token]
      return true
    else
      return nil
    end
  end
end

helpers do
  def protected!
    return if session[:shop_token]
    redirect '/'
  end
end


SETUP_PROC = lambda { |env| params = Rack::Utils.parse_query(env['QUERY_STRING'])
env['omniauth.strategy'].options[:client_options][:site] = "http://#{params['shop']}" }



use OmniAuth::Builder do
  provider :shopify, CONFIG["shopify_app_key"], CONFIG["shopify_app_secret"],:scope => CONFIG['shopify_scope'],:setup => SETUP_PROC
end


enable :sessions, :logging
set :session_secret, "supersecret"

get '/' do

  if session[:shop_token]
    #puts "We have a token and we're already logged in"
    shop = Shop.where(:shop => session[:shop]).first
    @status = shop.status
    erb :snow
  else
    puts "NO TOKEN"
    erb :login
  end
end


get '/snow?' do
  protected!
  erb :snow
end

get '/enable?' do
  protected!

  s = ShopifyAPI::Session.new("#{session[:shop]}", session[:shop_token])
  ShopifyAPI::Base.activate_session(s)

  themes = ShopifyAPI::Theme.all
  main_theme = ""

  themes.each do |theme|
    if theme.role == "main"
      main_theme =  theme
    end
  end

  liquid = ShopifyAPI::Asset.find('layout/theme.liquid', :params => {:theme_id => main_theme.id})
  script = "<script src=\"https://dl.dropboxusercontent.com/u/3687293/snow/snow.js\"></script>\n"
  shop = Shop.where(:shop => session[:shop]).first

  unless liquid.value.to_s.include? script
    # Insertion of Script into Shopify theme.
    liquid.value = liquid.value.to_s.gsub('</body>', "#{script}</body>")
    liquid.save
    content_type :json
    shop.status = "installed"
    shop.save
    puts '"message":"sucessfully installed"'
    '"message":"sucessfully installed"'
  else
    content_type :json
    puts '"message":"already installed"'
    '"message":"already installed"'
    shop.status = "installed"
    shop.save
  end

end

get '/disable?' do
  protected!

  s = ShopifyAPI::Session.new("#{session[:shop]}", session[:shop_token])
  ShopifyAPI::Base.activate_session(s)

  themes = ShopifyAPI::Theme.all
  main_theme = ""
  themes.each do |theme|
    if theme.role == "main"
      main_theme =  theme
    end
  end

  liquid = ShopifyAPI::Asset.find('layout/theme.liquid', :params => {:theme_id => main_theme.id})
  script = "<script src=\"https://dl.dropboxusercontent.com/u/3687293/snow/snow.js\"></script>\n"

  liquid.value = liquid.value.to_s.gsub(script, "")
  liquid.save

  shop = Shop.where(:shop => session[:shop]).first
  shop.status = "uninstalled"
  shop.save
  content_type :json
  puts '"message":"uninstalled"'
  '"message":"uninstalled"'
end

get '/auth/:name/callback' do

  puts "\n\n"
  puts "We're doing the authentication call back now"
  puts params.inspect
  puts "\n\n"


  @auth                = request.env['omniauth.auth']
  session[:shop]       = params["shop"]
  session[:shop_token] = @auth[:credentials][:token]


  shop = Shop.where(:shop => params["shop"]).first

  if shop
    shop.shop = params["shop"]
    shop.token = @auth[:credentials][:token]
    shop.save
  else
    shop = Shop.new
    shop.shop = params["shop"]
    shop.token = @auth[:credentials][:token]
    shop.save

    s = ShopifyAPI::Session.new(params["shop"], @auth[:credentials][:token])
    ShopifyAPI::Base.activate_session(s)
    billing = ShopifyAPI::RecurringApplicationCharge.create({:name => "Basic Plan", :price => 5.0, :trial_days => 2})

    log = Log.new

    log.shop = params["shop"]
    log.message = billing.inspect.to_s
    log.save

    redirect billing.confirmation_url

  end

  redirect '/'

end


get '/auth/failure' do

  redirect '/'

end

get '/admin/oauth/authorize' do
  @auth = request.env['omniauth.auth']
  "#{@auth.inspect}"
end


get '/keepalive' do
  "ok"
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/error' do
  "sorry and error has occured"
end