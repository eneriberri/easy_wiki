class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    render :new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :show
  end

  def update
    @post = Post.find(params[:id])
    if (params[:tag_list])
      @post.tag_list = params[:tag_list]
    end
    p params
    if @post.update_attributes(post_params)
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
