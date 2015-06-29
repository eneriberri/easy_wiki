class StaticPagesController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    render :index
  end
end
