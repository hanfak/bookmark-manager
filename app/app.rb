  ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

  register Sinatra::Flash
  use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb(:hello)
  end

  get '/sign_up/register' do
    @user = User.new
    erb :'/user/sign_up'
  end

  post '/sign_up' do
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'/user/sign_up'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'Goodbye!'
    redirect to '/'
  end

  post '/links' do
    link = Link.first_or_create(link_address: params[:link_address], link_name: params[:link_name])
    params[:link_tag].split.each do |tag|
      link.tags << Tag.first_or_create(tag: tag)
    end
    link.save
    redirect('/links')
  end

  get '/links' do
    @links = Link.all
    @tags = Tag.all
    erb(:'links/links')
  end

  get '/links/new' do
    erb(:'links/add_link')
  end

  get '/tags/:link_tag' do
    tag = Tag.first(tag: params[:link_tag])
    @links = tag ? tag.links : []
    erb(:'links/links')
  end

  run! if app_file == $0
end
