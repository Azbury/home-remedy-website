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
        @remedy = Remedy.new(remedy_params)
        if @remedy.save
            redirect_to user_remedy_path(@remedy)
        else
            render :new
        end
    end

    private

    def remedy_params
        params.require(:remedy).permit(:title, :description, :user_id)
    end

end