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
        @remedy = Remedy.find(params[:id])
    end

    def new
        @remedy = Remedy.new(user_id: params[:user_id])
    end

    def create
        @remedy = Remedy.new(remedy_params)
        if @remedy.save
            redirect_to user_remedy_path(id: @remedy.id, user_id: current_user.id)
        else
            render :new
        end
    end

    private

    def remedy_params
        params.require(:remedy).permit(:title, :description, :user_id, category_ids:[], categories_attributes: [:name])
    end

end