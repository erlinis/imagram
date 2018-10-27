class CommentsController < ApplicationController
 def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.save
    redirect_to posts_path
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
