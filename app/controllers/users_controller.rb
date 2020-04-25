class UsersController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]
    
    def index
        @users = User.all
    end

    def show
        if session[:user_id] == nil
            redirect_to '/'
        else
            @user = User.find(params[:id])
        end
    end

    def new
        if session[:user_id] == nil
            @user = User.new
        else
            redirect_to user_path(User.find_by(id: session[:user_id]))
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def elderly
        @elderly = User.elderly
    end

    def edit
        if params[:id].to_i != session[:user_id]
            redirect_to user_path(current_user), notice: "Can only edit your own account."
        else
            @user = User.find(params[:id])
        end
    end

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