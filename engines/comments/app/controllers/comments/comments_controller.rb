module Comments
  class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)

      if @comment.save
        redirect_to main_app.post_url(@post), notice: 'Comment added'
      else
        redirect_to main_app.post_url(@post), alert: 'Failed to add comment'
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @post = @comment.post
      @comment.destroy
      redirect_to main_app.post_url(@post), notice: 'Comment deleted'
    end

    private

    def comment_params
      params.require(:comment).permit(:author, :body)
    end
  end
end
