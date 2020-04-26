class SessionsController < ApplicationController
    #used for github oauth
    skip_before_action :verify_authenticity_token, only: :create
    #if you are not signed in you can only view these pages.
    skip_before_action :verified_user, only: [:new, :create, :home]
    
    #home page
    def home
    end

    #new account
    def new
      @user = User.new
    end

    #handles creation of new account
    def create
      #if singing in through github
      if auth
        user = User.find_by(id: auth['uid'])
        #if you already have an account through github
        if !user.nil?
          session[:user_id] = user.id
          redirect_to user_path(user)
        #first time making an account through github
        else
          user = User.create(:id => auth['uid']) do |user|
            user.username = auth['info']['nickname']
            user.first_name = auth['info']['name'].split(' ').first
            user.last_name = auth['info']['name'].split(' ').last
            user.age = 1
            user.bio = auth['extra']['raw_info']['bio']
            user.password = 'password'
          end
          session[:user_id] = user.try(:id)
          #having user update age and password on first time account creation because can not grab that info from github
          redirect_to edit_user_path(user), notice: "Thank you for signing up for an account using Github, please update your age and your password."
        end
      #if signing in through The Home Remedy website
      elsif user = User.find_by(username: params[:user][:username])
        #confirming password
        user = user.try(:authenticate, params[:password])
        return redirect_to signin_path, notice: "Incorrect Password" unless user
        session[:user_id] = user.id
        redirect_to user_path(user)
      #if username does not exist in database
      else
        redirect_to signin_path, notice: "Username not found"
      end
    
    end
    
    #helper method for github oauth
    def auth
      request.env['omniauth.auth']
    end
    
    #logout
    def destroy
      session.delete("user_id")
      redirect_to root_path
    end
end