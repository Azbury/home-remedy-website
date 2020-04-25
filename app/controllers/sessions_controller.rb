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
        user = User.find_by(id: auth['uid'])
        if !user.nil?
          session[:user_id] = auth['uid']
          redirect_to user_path(User.find(auth['uid']))
        else
          user = User.create(:id => auth['uid']) do |user|
            user.username = auth['info']['nickname']
            user.first_name = auth['info']['name'].split(' ').first
            user.last_name = auth['info']['name'].split(' ').last
            user.age = 0
            user.bio = auth['extra']['raw_info']['bio']
            user.password = 'password'
          end
          session[:user_id] = user.try(:id)
          redirect_to edit_user_path(user), notice: "Thank you for signing up for an account using Github, please update your age and your password."
        end
      elsif user = User.find_by(username: params[:user][:username])
        user = user.try(:authenticate, params[:password])
        return redirect_to signin_path, notice: "Incorrect Password" unless user
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to signin_path, notice: "Username not found"
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