$(document).ready(function() {

  EASY_WIKI.static_pages.index = {

    /*
     * publish a post and redirect to the created post
     *
     * called when the 'publish' button is clicked on
     * the home page
     */
    publish: function() {
      $.ajax({
        type: 'POST',
        url: 'api/posts/publish',
        data: {
          title: "Untitled Article",
          body: $('#write-post').html(),
          tags: $('.new-tags').val(),
        },
        success: function(post) {
          if (post && post.id) {
            window.location.href = "/posts/" + post.id;
          }
        }
      });
    },

    /* save the form values to localstorage and
     * open the 'new post' page
     *
     * called when the 'go fullscreen' button is clicked
     * on the home page
     */
    fullscreen: function() {
      var postBody = $('#write-post').html() !== "Start a new article..." ? $('#write-post').html() : null;
      var tags = $('.new-tags').val();
      if (postBody) {
        sessionStorage.setItem("temp_post_body", postBody);
      }
      if (tags) {
        sessionStorage.setItem("temp_post_tags", tags);
      }
      window.location.href = "/posts/new";
    },

    init: function() {

      //Handle search bar functionality
      submitSearch = function() {
        window.location.href = '/tagged?tag=' + $('#search-box').val();
      }

      $('#search-box').val("")
      $('#search-box').select2(
        {
          tags: true,
          query: function(options) {
            $.ajax({
              type: 'GET',
              url: encodeURI('api/tags/search/' + options.term)
            }).done(function(a) {
              result = [];
              for (var tag in a) {
                result.push({text: a[tag].text, id: a[tag].text})
              }
              options.callback({
                results: result,
                more: false
              })
            })
          }
        });

      $('.search-submit').on('click', submitSearch);


      //Create editor and animate its functionality
      var editor = new Pen({editor: document.getElementById('write-post'), stay: false}),
      $writePost = $('#write-post');
      $writePost.one('click', function(e) {
        $writePost.animate({'height': '180px'}, function() {
          $('.new-tag-wrapper').animate({'opacity': '1'});
          $('.new-btn-wrapper').animate({'opacity': '1'});
        });
      });


      //Top right nav bar animation and functionality
      var $tagOverlay = $('#tag-overlay');
      $('.fa-bar-link').on('click', function(e) {
        $('#nav-links').fadeOut();
        $tagOverlay.animate({'left': 0});
        $.ajax({
          url: '/api/tags/',
          type: 'GET',
          success: function(res) {
            for(var i = 0, n = res.length; i < n; i++) {
              var tag = res[i]['text'],
              link = '/tagged?tag=' + tag;

              $('.tags-overlay-wrapper').append('<a class="overlay-tag" href="'+link+'">'+tag+'</span>');
            }
          }
        });
      });

      $('.fa-times-link').on('click', function(e) {
        $('#nav-links').fadeIn();
        $tagOverlay.animate({'left': '100%'});
        $('.tags-overlay-wrapper').empty();
      });

    },
  }
});
