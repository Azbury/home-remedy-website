class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :verified_user
    helper_method :current_user
  
    private

    #if user is not logged in will redirect to home page
    def verified_user
      redirect_to '/' unless user_is_authenticated
    end
    
    #validates current user
    def user_is_authenticated
      !!current_user
    end
    
    #returns current user
    def current_user
      @user ||= User.find_by(id: session[:user_id])
    end
end
