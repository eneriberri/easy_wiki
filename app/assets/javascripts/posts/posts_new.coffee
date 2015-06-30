$ ->

  # page object for the posts new page
  EASY_WIKI.posts.new = {

    # called when the posts new page loads
    # initializes page variables
    init: ->
      @bodyEditor = new Pen('#post_body_editor')
      $('#post_body_editor').on('keyup click blur', @updateState);
      $('.pen-menu').on('click', @updateState);

    updateState: ->
      $('#post_body').val($('#post_body_editor').html());
  }
