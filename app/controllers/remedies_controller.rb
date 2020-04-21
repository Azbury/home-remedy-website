class RemediesController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def index
        if params[:user_id]
            @remedies = User.find(params[:user_id]).remedies
        else
            @remedies = Remedy.all
        end
    end

    def show
        @remedy = Remedy.find_by(id: params[:id])
    end

    def new
        @remedy = Remedy.new(user_id: params[:user_id])
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

    private

    def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :age, :bio, :password)
    end

end