class CommentsController < ApplicationController
    def new
        @comment = Comment.new(remedy_id: params[:remedy_id], user_id: session[:user_id])
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            redirect_to user_remedy_path(id: @comment.remedy_id, user_id: @comment.user_id)
        else
            render :new
        end
    end

    private

    def remedy_params
        params.require(:comment).permit(:content, :user_id, :remedy_id)
    end
end