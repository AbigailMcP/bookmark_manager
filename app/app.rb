ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/user'
require_relative 'data_mapper_setup'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'

  get '/' do
    redirect '/signup'
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    if User.get(user.id)
      redirect '/links'
    else
      flash[:error] = 'Password and confirmation password do not match'
      flash[:email] = params[:email]
      flash[:name] = params[:name]
      redirect '/signup'
    end
  end

  get '/links' do
    @links = Link.all
    user = User.get(session[:user_id])
    @name = user.name if user
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
