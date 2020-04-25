class RemediesController < ApplicationController

    def index
        if params[:user_id]
            @remedies = User.find(params[:user_id]).remedies
        else
            @remedies = Remedy.all
        end
    end

    def show
        @remedy = Remedy.find(params[:id])
    end

    def new
        if params[:user_id].to_i != session[:user_id]
            redirect_to user_path(current_user), notice: "Can only make a new remedy from your own account."
        else
            @remedy = Remedy.new(user_id: params[:user_id])
        end
    end

    def create
        @remedy = Remedy.new(remedy_params)
        if @remedy.save
            redirect_to user_remedy_path(id: @remedy.id, user_id: current_user.id)
        else
            render :new
        end
    end

    def edit
        if params[:user_id]
          user = User.find_by(id: params[:user_id])
          if user.nil?
            redirect_to users_path, alert: "User not found."
          else
            @remedy = user.remedies.find_by(id: params[:id])
            redirect_to user_remedies_path(user), alert: "Remedy not found." if @remedy.nil?
          end
        else
          @remedy = Remedy.find(params[:id])
        end
    end
    private

    def remedy_params
        params.require(:remedy).permit(:title, :description, :user_id, category_ids:[])
    end

end