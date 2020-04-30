class UsersController < ApplicationController
    #if you are not signed in you can only view these pages.
    skip_before_action :verified_user, only: [:new, :create]
    
    #list of users
    def index
        @users = User.all
    end

    #user home pages
    def show
        @user = User.find(params[:id])
    end

    #new user page
    def new
        if session[:user_id] == nil
            @user = User.new
        else
            #if user is already signed in and trying to make an account will redirect to your account page.
            redirect_to user_path(User.find_by(id: current_user.id)), notice: "You already have an account!"
        end
    end

    #handles creating new account
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            #if user does not meet all validations will render new form
            render :new
        end
    end

    #list of elderly users
    def elderly
        @elderly = User.elderly
    end

    #edit user page
    def edit
        #will not users edit others users account
        if params[:id].to_i != current_user.id
            redirect_to user_path(current_user), notice: "Can only edit your own account."
        else
            @user = User.find(params[:id])
        end
    end

    #handles editing a user account
    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to user_path(@user)
    end

    private

    def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :age, :bio, :password)
    end

end