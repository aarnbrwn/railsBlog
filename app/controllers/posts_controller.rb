class PostsController < ApplicationController
  def index
    @user_post = User.find_by_id(session[:user_id])
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(@post.user_id)
  end

  def new
    @user_post = User.find_by_id(session[:user_id])
    @post = Post.new
  end

  def create
    user = User.find(session[:user_id])
    post = Post.new(posts_params)
    post.user_id = user.id
    if post.save
      redirect_to '/posts'
      flash[:message] = 'Post Created'
    else
      redirect_to '/posts/new'
      flash[:message] = 'Failed To Create Post'
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    @comment = Comment.find_by_id(params[:id])
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(posts_params)
      flash[:message] = 'Post Updated Successfully'
      redirect_to "/posts/#{@post.id}"
    else
      flash[:message] = "Unsuccessful Update"
      render "/posts/#{@post.id}/edit"
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy
    redirect_to '/'
    flash[:message] = 'Post Deleted'
  end

  private

    def posts_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
