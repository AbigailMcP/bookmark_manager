ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/user'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    redirect '/signup'
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:name] = user.name
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    @name = session[:name]
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split(", ").each do |tag|
      new_tag = Tag.first_or_create(tag: tag)
      link.tags << new_tag
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    @links = Tag.all(:tag => params[:name]).links
    @tag_name = params[:name]
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
