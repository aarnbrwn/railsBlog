class CommentsController < ApplicationController
  def index
    user = User.find_by_id(session[:user_id])
    post = Post.find_by_id(params[:id])
  end

  def new
    @comment = Comment.new
    @post = Post.find_by_id(params[:id])
  end

  def create
    @user = User.find_by_id(session[:user_id])
    @post = Post.find(params[:post_id])
      @comment = @post.comments.new(comment_params)
      @comment.user_id = @user.id
      @comment.post_id = @post.id
      @comment.save
      redirect_to "/posts/#{@post.id}"
  end

  def edit
    @user = User.find_by_id(session[:user_id])
    @post = Post.find_by_id(params[:id])
    @comment = Comment.find_by_id(params[:id])
  end

  # def show
  #   @comment = Comment.find_by_id(params[:id])
  # end

  def update
    @post = Post.find_by_id(params[:id])
    @comment = Comment.find_by_id(params[:id])
    if @comment.update(comment_params)
      redirect_to "/posts/#{@comment.post_id}"
      flash[:message] = 'Comment Updated'
    else
      flash[:message] = 'Failed To Update Comment'
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy()
    redirect_to '/'
    flash[:message] = "comment Deleted"
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
