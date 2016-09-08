ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    redirect '/sign_in'
  end

  get '/links' do
    @links = Link.all
    @user_name = session[:user_name]
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tags = params[:tag].split(',')
    tags.each do |each_tag|
      tag = Tag.first_or_create(tag: each_tag)
      link.tags << tag
    end
    link.save
    redirect '/links'
  end

  get '/tags/:tag' do
    tag = Tag.first(tag: params[:tag])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    @user = User.create(name: params[:name],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])
    if @user.id != nil
      session[:user_name] = @user.name
      redirect '/links'
    else
      flash[:error] = @user.errors.full_messages
      redirect '/sign_up'
    end
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/sign_in' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_name] = user.name
      redirect '/links'
    else
      flash[:login_failed] = "Login failed!"
      redirect '/sign_in'
    end
  end

  post '/sign_out' do
    session[:user_name] = nil
    flash[:signed_out] = 'Signed out - come back soon'
    redirect '/sign_in'
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
