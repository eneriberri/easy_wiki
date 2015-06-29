class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    render :new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
  
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
  
    if @post.update_attributes(params[:post])
      render :show
    else
      render :json => "ruh roh"
    end
  end

  def destroy
    #TODO
  end
  
  def tagged
    if params[:tag].present? 
      @posts = Post.tagged_with(params[:tag])
    else 
      @posts = Post.all
    end  
    render :index
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :user_id, :tag_list)
  end
end
