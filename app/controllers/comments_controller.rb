class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_commentable, only: :create

    def new
      @comment = Comment.new
    end

    def create
      @commentable.comments.build(comment_params)
      if @commentable.save
       redirect_to request.referrer, notice: 'Comment posted!'
      else
        redirect_to request.referrer, notice: "Something went wrong comment not posted!"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_commentable
      if params[:comment_id]
        @commentable = Comment.find_by_id(params[:comment_id]) 
      elsif params[:post_id]
        @commentable = Post.find_by_id(params[:post_id])
      end
    end
end
