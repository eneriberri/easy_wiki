$ ->

  # page object for the posts new page
  EASY_WIKI.posts.new = {

    # called when the posts new page loads
    # initializes page variables
    init: ->
      $('#post_body_editor').html($('#post_body').text()) if $('#post_body').text();
      @bodyEditor = new Pen({editor: document.getElementById('post_body_editor'), stay: false})
      $('#post_body_editor').on('keyup click blur', @updateState);
      $('.pen-menu').on('click', @updateState);


    updateState: ->
      $('#post_body').val($('#post_body_editor').html());
  }
