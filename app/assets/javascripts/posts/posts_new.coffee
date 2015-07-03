$ ->

  # page object for the posts new page
  EASY_WIKI.posts.new = {

    # called when the posts new page loads
    # initializes page variables
    init: ->
      # if we have a temp post from session storage, use that
      if body = sessionStorage.getItem("temp_post_body")
        $('#post_body').text(body)
        sessionStorage.removeItem("temp_post_body")

      if tags = sessionStorage.getItem("temp_post_tags")
        $('.new-tags').val(tags)
        sessionStorage.removeItem("temp_post_tags")

      # the placeholder text for the post body editor
      @placeholderText = "<span style='color:rgb(204, 204, 204);'>Write here...</span>";
      if $('#post_body').text()
        $('#post_body_editor').html($('#post_body').text());
      else
        $('#post_body_editor').html(@placeholderText)

      @bodyEditor = new Pen({editor: document.getElementById('post_body_editor'), stay: false})
      $('#post_body_editor').on('keyup click blur', @updateState);
      $('.pen-menu').on('click', @updateState);
      $.ajax({
        url: '/api/tags/',
        type: 'GET',
        success: (res) ->
          for tag in res
            tag.id = tag.text
          $('.new-tags').select2(
            {
              placeholder: "Enter tags here",
              tags: res,
              tokenSeparators: [",", "  "]
            });
      });
      $('#post_body_editor').on('focus', =>
        $('#post_body_editor').css({"background-color":"rgb(250, 250, 250)"})
        text = $('#post_body_editor').text().trim()
        if text == "Write here..."
          $('#post_body_editor').html("")
        );
      $('#post_body_editor').on('blur', =>
        $('#post_body_editor').css("background-color", "")
        text = $('#post_body_editor').text().trim()
        if text == ""
          $('#post_body_editor').html(@placeholderText)
        );

    updateState: ->
      $('#post_body').val($('#post_body_editor').html());

  }
