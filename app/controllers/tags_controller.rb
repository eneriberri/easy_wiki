class TagsController < ApplicationController

  # (allthethings)
  def allthetags
    @posts = Post.all
    @tags = {}
    @tagArray = []
    @posts.each do |post|
      post.tags.each do |tag|
        @tags[tag.id] = tag
      end
    end

    @tags.each do |tag|
      @tagArray.push({text: tag[1].name, id:tag[1].id, count:tag[1].taggings_count})
    end
    render :json => @tagArray
  end

  def tagsearch
    @name = params[:name].downcase
    @posts = Post.all
    @tags = {}
    @tagArray = []
    @posts.each do |post|
      post.tags.each do |tag|
        if tag.name.downcase.index(@name) != nil
          @tags[tag.id] = tag
        end
      end
    end

    @tags.each do |tag|
      @tagArray.push({text: tag[1].name, id:tag[1].id, count:tag[1].taggings_count})
    end
    render :json => @tagArray
  end

end
