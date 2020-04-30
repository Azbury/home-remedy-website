class RemediesController < ApplicationController

    #list of remedies
    def index
        if params[:user_id]
            @remedies = User.find(params[:user_id]).remedies
        else
            @remedies = Remedy.all
        end
    end

    #remedy show page
    def show
        @remedy = Remedy.find(params[:id])
    end

    #new remedy page
    def new
        #does not let a user make a remedy from another users account
        if params[:user_id].to_i != current_user.id
            redirect_to user_path(current_user), notice: "Can only make a new remedy from your own account."
        else
            @remedy = Remedy.new(user_id: params[:user_id])
        end
    end

    #handles creating a new remedy
    def create
        @remedy = Remedy.new(remedy_params)
        if @remedy.save
            redirect_to user_remedy_path(id: @remedy.id, user_id: current_user.id)
        else
            #will render new remedy form if not meeting all validations
            render :new
        end
    end

    #edit remedy page
    def edit
        #does not let a user edit a remedy from another users account
        if params[:user_id].to_i != current_user.id
            redirect_to user_path(current_user), notice: "Can only edit remedies you created."
        else
          @remedy = Remedy.find(params[:id])
        end
    end

    #handles updating remedy
    def update
        @remedy = Remedy.find(params[:id])
        @remedy.update(remedy_params)
        redirect_to user_remedy_path(id: @remedy.id, user_id: @remedy.user.id)
    end
    
    private

    def remedy_params
        params.require(:remedy).permit(:title, :description, :user_id, category_ids:[])
    end

end