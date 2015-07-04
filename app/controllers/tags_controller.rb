class TagsController < ApplicationController

  # get all the tags
  # (allthethings)
  def allthetags
    @tagArray = []
    ActsAsTaggableOn::Tag.all.each do |tag|
      @tagArray.push({text: tag.name, id:tag.id, count:tag.taggings_count})
    end
    render :json => @tagArray
  end

  # get tags which contain a provided search string
  # the search string should be provided as the :name params
  #
  # returns a json array with all tags which contain the :name
  # as part of their tag names
  def tagsearch
    @name = params[:name].downcase
    @tagArray = []
    ActsAsTaggableOn::Tag.all.each do |tag|
      if tag.name.downcase.index(@name) != nil
        @tagArray.push({text: tag.name, id:tag.id, count:tag.taggings_count})
      end
    end
    render :json => @tagArray
  end

end
