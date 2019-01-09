ENV['RACK_ENV'] = 'development'

require './config/data_mapper'
require 'dm-validations'
require 'pry'
require 'sinatra/base'
require 'sinatra/flash'

class UserAuth < Sinatra::Base
  enable :sessions
  enable :method_override
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/profile' do
    if signed_in?
      erb :profile
    else
      redirect 'signin'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do

    redirect '/error' unless params[:password].length > 5

    user = User.create(email: params[:email], password: params[:password])

    redirect '/error' unless user.valid?
    if user
      session[:user_id] = user.id
      flash[:signup_sucess] = "You signed up successfully!"
      redirect '/profile'
    else
      redirect '/'
    end
  end

  get '/error' do
    erb :error
  end

  get '/signin' do
    erb :signin
  end

  post '/signin' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/profile'
    else
      redirect '/'
    end
  end

  delete '/sessions' do
    session.delete(:user_id)
    redirect '/'
  end

  private

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end
