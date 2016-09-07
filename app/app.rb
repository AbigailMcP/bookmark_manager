ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'models/link'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
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
