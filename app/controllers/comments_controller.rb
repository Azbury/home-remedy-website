class CommentsController < ApplicationController
    #new comment page
    def new
        @comment = current_user.comments.build(remedy_id: params[:remedy_id])
    end

    #handles creating new comments
    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            redirect_to user_remedy_path(id: @comment.remedy_id, user_id: @comment.user_id)
        else
            #if user does not meet the validations for a comment will create a new form
            render :new
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :remedy_id)
    end
end