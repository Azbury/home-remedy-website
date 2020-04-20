class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    skip_before_action :verified_user, only: [:new, :create, :home]
    
    def home

    end

    def new
      @user = User.new
    end

    def create
      if auth
        user = User.find_or_create_by(:id => auth['uid']) do |user|
          user.username = auth['info']['nickname']
          user.first_name = auth['info']['name'].split(' ').first
          user.last_name = auth['info']['name'].split(' ').last
          user.age = 0
          user.bio = auth['extra']['raw_info']['bio']
          user.password = 'password'
        end
        session[:user_id] = user.try(:id)
        redirect_to user_path(user)
      elsif @user = User.find_by(username: params[:user][:username])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render 'new'
      end
    
    end
  
    def auth
      request.env['omniauth.auth']
    end
  
    def destroy
      session.delete("user_id")
      redirect_to root_path
    end
end