ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class Bookmark < Sinatra::Base

  enable :sessions
  set :session_secret, "super secret"

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links/created' do
    link = Link.new(:title => params[:title], :url => params[:url])
    params[:tag].split.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = (tag ? tag.links : [])
    erb(:'links/index')
  end

  get '/users/new' do
    erb(:'users/new')
  end

  post '/users/created' do
    user = User.new(:email => params[:email], :password => params[:password])
    user.save
    session[:user_id] = user.id
    redirect '/links'
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
