# page-specific javascript for all posts views
$ ->

  EASY_WIKI.posts = {
    # called when any posts page is loaded
    init: ->
      #Top right nav bar animation and functionality
      tagOverlay = $('#tag-overlay');
      $('.fa-bar-link').on('click', (e) ->
        $(e.target).fadeOut();
        tagOverlay.animate({'left': 0});
        $.ajax({
          url: '/api/tags/',
          type: 'GET',
          success: (res) ->
            for tag in res
              text = tag['text']
              link = '/tagged?tag=' + text
              $('.tags-overlay-wrapper').append("<a class='overlay-tag' href='#{link}'>#{text}</span>")
        });
      );

      $('.fa-times-link').on('click', (e) ->
        $('.fa-bars').fadeIn();
        tagOverlay.animate({'left': '100%'});
        $('.tags-overlay-wrapper').empty();
      );
  }
