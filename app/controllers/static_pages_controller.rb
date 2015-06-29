class StaticPagesController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    render :index
  end
  
  def tagged
    if params[:tag].present? 
      @posts = Post.tagged_with(params[:tag])
    else 
      @posts = Post.all
    end  
  end
end
