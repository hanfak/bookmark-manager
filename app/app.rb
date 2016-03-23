ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
# require './app/models/link'
require_relative 'data_mapper_setup'

class App < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split.each do |one_tag|
      link.tags << Tag.create(name: one_tag)
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb(:'links/index')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
